defmodule Wallet.Wallets.Aggregates.Wallet do
  defstruct id: nil, name: "", balances: []

  alias Wallet.Wallets.Commands.CreateWallet
  alias Wallet.Wallets.Events.WalletCreated
  alias __MODULE__

  @doc """
  Create a wallet
  """
  def execute(%Wallet{id: nil}, %CreateWallet{} = create_wallet) do
    %WalletCreated{
      id: create_wallet.id,
      name: create_wallet.name,
      balances: create_wallet.balances
    }
  end

  # state mutators

  def apply(%Wallet{} = wallet, %WalletCreated{} = created_wallet) do
    %Wallet{
      wallet
      | id: created_wallet.id,
        name: created_wallet.name,
        balances: created_wallet.balances
    }
  end
end
