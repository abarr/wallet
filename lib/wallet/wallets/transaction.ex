defmodule Wallet.Wallets.Transaction do
  @moduledoc """
  Schema - Transaction
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Wallet.Wallets.Entry

  schema "transactions" do
    field :description, :string
    field :type, Ecto.Enum, values: [:purchase, :refund, :stake, :prize, :disbursement, :entry]
    has_many :entries, Entry

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:description, :type])
    |> validate_required([:description, :type])
  end

  def deposit_description(%{to_wallet: to, from_wallet: _from, amount: money}) do
    "Deposit: #{money.currency} #{money.amount} to #{to.name}"
  end

  def transfer_description(%{to_wallet: to, from_wallet: from, amount: money}) do
    "Transfer: #{money.currency} #{money.amount} from #{from.name} to #{to.name}"
  end

  def withdrawal_description(%{to_wallet: _to, from_wallet: from, amount: money}) do
    "Withdrawal: #{money.currency} #{money.amount} from #{from.name}"
  end
end
