import Config

config :wallet, Wallet.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: Wallet.EventStore
  ],
  pub_sub: :local,
  registry: :local

config :wallet, Wallet.Repo,
  database: "wallet_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :wallet,
  ecto_repos: [Wallet.Repo],
  event_stores: [Wallet.EventStore]

config :ex_cldr,
  default_backend: Wallet.Cldr,
  json_library: Jason

config :ex_money,
  default_cldr_backend: Wallet.Cldr

config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore

config :commanded_ecto_projections,
  repo: Wallet.Repo

import_config "#{config_env()}.exs"
