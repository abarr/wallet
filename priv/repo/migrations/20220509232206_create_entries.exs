defmodule Wallet.Repo.Migrations.CreateEntries do
  use Ecto.Migration

  def change do
    create table(:entries) do
      add :amount, :money_with_currency
      add :type, :entry_type
      add :transaction_id, references(:transactions, on_delete: :delete_all)
      add :wallet_id, references(:wallets, on_delete: :delete_all)
      timestamps()
    end
  end
end
