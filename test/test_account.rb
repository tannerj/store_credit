require_relative '../lib/store_credit/account'
require 'test/unit'

class TestCredit < Test::Unit::TestCase
  def tests_can_set_value
    @account  = StoreCredit::Account.new(100)
    assert_equal(100, @account.balance)
  end

  def tests_can_withdraw_from_credit
    @account = StoreCredit::Account.new(100)
    assert_equal(@account.withdraw(20), 20)
  end

  def tests_withdraw_reduces_balance
    @account = StoreCredit::Account.new(100)
    @account.withdraw(20)
    assert_equal(@account.balance, 80)
  end

  def tests_withdraw_throws_insufficient_funds_exception_on_overdraft
    @account = StoreCredit::Account.new(100)
    assert_raises(StoreCredit::Account::InsufficientFunds) { @account.withdraw(120)  }
  end

  def tests_deposite_correctly_updates_balance
    @account = StoreCredit::Account.new(100)
    @account.deposit(20)
    assert_equal(@account.balance, 120)
  end
end
