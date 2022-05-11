defmodule Wallet.Wallets.Commands.CreateWallet do
  defstruct id: nil, name: "", balances: []

  def new(%{"name" => name, "id" => id}) do
    %__MODULE__{id: id, name: name, balances: []}
  end
end
