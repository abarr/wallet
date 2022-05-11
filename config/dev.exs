import Config

config :wallet, env: :dev

# Configures the event store database
config :wallet, Wallet.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "wallet_eventstore_dev",
  hostname: "localhost",
  pool_size: 1
