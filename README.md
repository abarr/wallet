# Wallet

1. Clone repo
2. cd wallet
3. mix deps.get
4. mix event_store.create -e Wallet.EventStore
5. mix event_store.init -e Wallet.EventStore
6. mix ecto.reset
7. iex -S mix


Create a Wallet:

```
iex(2)> Wallet.create_wallet(%{"name" => "Wallet Name"})
```


```
iex(2)> Wallet.create_wallet(%{"name" => "Wallet Name"})
```
