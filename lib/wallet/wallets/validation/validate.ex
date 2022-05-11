defmodule Wallet.Wallets.Validation.Validate do
  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline
  alias Wallet.Repo
  alias Wallet.Wallets.Commands.CreateWallet
  alias Wallet.Wallets.Projections.Wallet
  import Pipeline

  def before_dispatch(%Pipeline{command: %CreateWallet{} = cmd} = pipeline) do
    case Repo.get_by(Wallet, name: cmd.name) do
      nil -> pipeline
      _ -> failed_validation(pipeline, "Wallet already exists")
    end
  end

  def after_dispatch(pipeline), do: pipeline
  def after_failure(pipeline), do: pipeline

  defp failed_validation(%Pipeline{} = pipeline, msg) do
    pipeline
    |> respond({:error, :validation_failure, msg})
    |> halt()
  end

end
