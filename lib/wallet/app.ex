defmodule Wallet.App do
  use Commanded.Application, otp_app: :wallet
  router Wallet.Wallets.Router
end
