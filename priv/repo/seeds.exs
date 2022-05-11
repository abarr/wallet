# Create Wallets
Wallet.Repo.insert(
  %Wallet.Wallets.Projections.Wallet{
    id: UUID.uuid4(),
    name: "trust",
    balances: [
      %{amount: 0, currency: :USD}
    ]
  }
)

Wallet.Repo.insert(
  %Wallet.Wallets.Projections.Wallet{
    id: UUID.uuid4(),
    name: "capital",
    balances: [
      %{amount: 0, currency: :USD}
    ]
  }
)
