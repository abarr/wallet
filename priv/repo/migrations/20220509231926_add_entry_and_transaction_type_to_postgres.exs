defmodule Wallet.Repo.Migrations.AddEntryAndTransactionTypeToPostgres do
  use Ecto.Migration

  def up do
    execute("CREATE TYPE public.entry_type AS ENUM ('credit', 'debit')")
    execute("CREATE TYPE public.transaction_type AS ENUM ('purchase', 'refund', 'stake', 'prize', 'disbursement', 'entry')")
  end

  def down do
    execute("DROP TYPE public.entry_type;")
    execute("DROP TYPE public.transaction_type;")
  end
end
