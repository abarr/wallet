defmodule Wallet do
  @moduledoc """
  Documentation for `Wallet`.
  """

  alias Wallet.Repo
  alias Wallet.App
  alias Wallet.Wallets.Commands.CreateWallet

  @doc """
  Create a wallet

  ## Examples

      iex> Wallet.create("name")
      {:ok, wallet}

  """
  def create_wallet(params) do
    id = UUID.uuid4()

    create_wallet =
      params
      |> Map.put("id", id)
      |> CreateWallet.new()

    with :ok <- App.dispatch(create_wallet, consistency: :strong) do
      get(Wallet.Wallets.Projections.Wallet, id)
    end
  end

  defp get(schema, id) do
    case Repo.get(schema, id) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end

# Wallet.create_wallet(%{"name" => "Test"})
