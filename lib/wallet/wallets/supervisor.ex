defmodule Wallet.Wallets.Supervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  def init(_args) do
    Supervisor.init(
      [
        Wallet.Wallets.Projectors.Wallet
      ],
      strategy: :one_for_one
    )
  end
end
