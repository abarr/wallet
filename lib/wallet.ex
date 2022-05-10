defmodule Wallet do
  @moduledoc """
  Documentation for `Wallet`.
  """

  alias Ecto.Multi
  alias Wallet.Repo
  alias Wallet.Wallets.{Entry, Transaction, Wallet}

  @grilla_wallet "Grilla"

  @doc """
  Create a wallet

  ## Examples

      iex> Wallet.create("name")
      {:ok, wallet}

  """
  def create_wallet(params) do
    %Wallet{}
    |> Wallet.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Get a wallet by name

  ## Examples

      iex> Wallet.get_wallet_by_name("name")
      {:ok, wallet}

  """
  def get_wallet_by_name(name) when is_binary(name) do
    Repo.get_by(Wallet, name: name)
  end

  @doc """
  Get Grilla wallet

  ## Examples

      iex> Wallet.get_grilla_wallet
      {:ok, wallet}

  """
  def get_grilla_wallet(name \\ @grilla_wallet) when is_binary(name) do
    get_wallet_by_name(name)
  end

  @doc """
  Get Balance of Wallet

  ## Examples

      iex> Wallet.balance(%Wallet{} = wallet)
      %Money{currency: :USD, amount: 1000}
  """
  def balance(wallet) do
    credits = Entry.amount(Repo, wallet, :credit)
    debits = Entry.amount(Repo, wallet, :debit)

    credits =
      case is_nil(credits) do
        true ->
          {_, credit} = Money.new(:USD, 0)
          [credit]

        false ->
          credits
      end

    debits =
      case is_nil(debits) do
        true ->
          {_, debits} = Money.new(:USD, 0)
          [debits]

        false ->
          debits
      end

    Money.sub(credits, debits)
  end

  @doc """
  User deposits funds into their Wallet

  ## Examples

      iex> Wallet.purchase(%Wallet{} = to_wallet, %Wallet{} = from_wallet, amount)
       {:ok,
          %{
            amount: Money.new(:USD, "1000"),
            credit_entry: ...,
            debit_entry: ...,
            transaction: ...
          }
        }
  """
  def purchase(to_wallet, from_wallet, amount, multi \\ Multi.new) do
    multi
    |> Multi.put(:to_wallet, to_wallet)
    |> Multi.put(:from_wallet, from_wallet)
    |> Multi.put(:amount, amount)
    |> Multi.insert(:transaction, fn params ->
      description = Transaction.deposit_description(params)
      Transaction.changeset(%Transaction{}, %{description: description, type: :purchase})
    end)
    |> Multi.insert(:credit_entry, fn params ->
      attrs = %{
        type: :credit,
        wallet_id: params.to_wallet.id,
        transaction_id: params.transaction.id,
        amount: params.amount
      }
      Entry.changeset(%Entry{}, attrs)
    end)
    |> Multi.insert(:debit_entry, fn params ->
      attrs = %{
        type: :debit,
        wallet_id: params.from_wallet.id,
        transaction_id: params.transaction.id,
        amount: params.amount
      }
      Entry.changeset(%Entry{}, attrs)
    end)
    |> Repo.transaction()
  end
end
