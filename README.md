# Wallet

1. Clone repo
2. cd wallet
3. mix deps.get
4. mix event_store.create -e Wallet.EventStore
5. mix event_store.init -e Wallet.EventStore
6. mix ecto.reset
7. iex -S mix

```
iex(2)> Wallet.create_wallet(%{"name" => "Test"})

# Result
{:ok,
 %Wallet.Wallets.Projections.Wallet{
   __meta__: #Ecto.Schema.Metadata<:loaded, "wallets">,
   balances: [%{"amount" => "0", "currency" => "USD"}],
   id: "f195e6b8-2dfe-4dbb-8f20-67ef015acdb4",
   inserted_at: ~U[2022-05-11 03:05:24.000000Z],
   name: "Test",
   updated_at: ~U[2022-05-11 03:05:24.000000Z]
 }}

```
