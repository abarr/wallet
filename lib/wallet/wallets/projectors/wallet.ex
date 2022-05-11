defmodule Wallet.Wallets.Projectors.Wallet do
  use Commanded.Projections.Ecto,
    application: Wallet.App,
    name: "Wallet.Wallets.Projectors.Wallet",
    repo: Wallet.Repo,
    consistency: :strong

  alias Wallet.Wallets.Events.WalletCreated
  alias Wallet.Wallets.Projections.Wallet

  require Logger

  project(%WalletCreated{} = wallet_created, fn multi ->
    Ecto.Multi.insert(multi, :wallet, %Wallet{
      id: wallet_created.id,
      name: wallet_created.name,
      balances: [Money.new(:USD, 0)]
    })
  end)

  def error({:error, error}, _, _) do
    Logger.error(fn -> "Failed due to constraint error: " <> inspect(error) end)
    :skip
  end
end
