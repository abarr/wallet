defmodule Wallet.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string, null: false
      add :balances, {:array, :money_with_currency}, default: []
      timestamps()
    end
  end
end
