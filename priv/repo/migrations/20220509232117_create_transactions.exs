defmodule Wallet.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :description, :string, null: false
      add :type, :transaction_type
      timestamps()
    end
  end
end
