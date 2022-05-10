import Config

config :wallet, Wallet.Repo,
  database: "wallet_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :wallet, ecto_repos: [Wallet.Repo]

config :ex_cldr,
  default_backend: Wallet.Cldr,
  json_library: Jason

config :ex_money,
  default_cldr_backend: Wallet.Cldr
