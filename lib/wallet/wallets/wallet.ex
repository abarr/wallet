defmodule Wallet.Wallets.Wallet do
  @moduledoc """
  Schema - Wallet
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Wallet.Wallets.Entry

  schema "wallets" do
    field :name, :string
    has_many :entries, Entry

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
