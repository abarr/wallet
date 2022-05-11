defmodule Wallet.Wallets.Commands.CreateWallet do
  defstruct id: nil, name: "", balances: []

  def new(%{"name" => name, "id" => id}) do
    %__MODULE__{id: id, name: name, balances: [Money.new(:USD, 0)]}
  end
  def new(%{"name" => name, "id" => id, "balances" => balances}) do
    %__MODULE__{id: id, name: name, balances: balances}
  end
end
