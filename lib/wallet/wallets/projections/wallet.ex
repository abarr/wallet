defmodule Wallet.Wallets.Projections.Wallet do
  @moduledoc """
  Schema - Wallet
  """
  use Ecto.Schema
  # import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime_usec]

  schema "wallets" do
    field :name, :string
    field :balances, {:array, :map}
    timestamps()
  end
end
