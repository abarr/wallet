defmodule WalletTest do
  use ExUnit.Case

  setup do
    {:ok, grilla_wallet} = Wallet.create_wallet(%{name: "Grilla"})
    {:ok, user_wallet} = Wallet.create_wallet(%{name: "User_1"})
    %{grilla_wallet: grilla_wallet, user_wallet: user_wallet}
  end

  test "create wallets" do
    for wallet <- ["Grilla", "User 1"] do
      assert {:ok, _wallet} = Wallet.create_wallet(%{name: wallet})
    end
  end

  test "user deposits funds into their wallet", %{grilla_wallet: grilla_wallet, user_wallet: user_wallet} do

    {:ok, %{ amount: amount, credit_entry: credit, debit_entry: debit, transaction: transaction}} =
      Wallet.purchase(user_wallet, grilla_wallet, Money.new!(:USD, 1000))

    assert amount.amount == Decimal.new(1000)
    assert :credit = credit.type
    assert credit.amount == Money.new(:USD,1000)
    assert :debit = debit.type
    assert credit.amount == Money.new(:USD,1000)
    assert "Deposit: USD 1000 to User_1" = transaction.description
  end
end
