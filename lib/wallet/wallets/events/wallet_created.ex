defmodule Wallet.Wallets.Events.WalletCreated do
  @derive Jason.Encoder
  defstruct id: nil, name: "", balances: []
end
