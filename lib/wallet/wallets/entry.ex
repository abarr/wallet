defmodule Wallet.Wallets.Entry do
  @moduledoc """
  Schema - Entry
  """
  import Ecto.Query
  import Ecto.Changeset

  use Ecto.Schema

  alias Wallet.Wallets.{Transaction, Wallet}

  schema "entries" do
    field :amount, Money.Ecto.Composite.Type
    field :type, Ecto.Enum, values: [:debit, :credit]
    belongs_to :transaction, Transaction
    belongs_to :wallet, Wallet

    timestamps()
  end

  @doc false
  def changeset(entry, attrs) do
    entry
    |> cast(attrs, [:amount, :type, :transaction_id, :wallet_id])
    |> validate_required([:amount, :type, :transaction_id, :wallet_id])
  end

  @doc false
  def amount(repo, wallet, type) do
    results =
      Entry
      |> where([entry: entry], entry.type == ^type and entry.wallet_id == ^wallet.id)
      |> select([entry: entry], sum(entry.amount))
      |> repo.all()

    Enum.reduce(results, Money.new(:USD, 0), fn amt, acc ->
      {_, new_amt} = Money.add(amt, acc)
      new_amt
    end)
  end
end
