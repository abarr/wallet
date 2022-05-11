defmodule Wallet.Wallets.Router do
  use Commanded.Commands.Router

  middleware(Wallet.Wallets.Validation.Validate)

  dispatch(Wallet.Wallets.Commands.CreateWallet, to: Wallet.Wallets.Aggregates.Wallet, identity: :id)

end
