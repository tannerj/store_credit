module StoreCredit
  class Error < RuntimeError; end
  class Account
    class InsufficientFunds < StoreCredit::Error; end

    attr_reader :balance
    
    def initialize(credit)
      @balance = credit
    end

    def deposit(amount)
      @balance += amount
    end

    def withdraw(amount)
      raise InsufficientFunds if amount > @balance
      @balance -= amount
      amount
    end
  end
end
