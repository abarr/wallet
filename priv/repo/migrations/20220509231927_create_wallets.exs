defmodule Wallet.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :name, :string, null: false
      timestamps()
    end
  end
end
