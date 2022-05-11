import Config

config :wallet, env: :test

# Configures the event store database
config :wallet, Wallet.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "wallet_eventstore_test",
  hostname: "localhost",
  pool_size: 1

# Configures the read store database
config :wallet, Wallet.Repo,
  username: "postgres",
  password: "postgres",
  database: "wallet_test",
  hostname: "localhost",
  pool_size: 1
