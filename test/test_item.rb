require_relative '../lib/store_credit/item'
require 'test/unit'

class TestItem < Test::Unit::TestCase
  
  def tests_can_create_item
    @item = StoreCredit::Item.new(position: 1, price: 10)
  end

  def tests_ensure_position_is_immutable
    @item = StoreCredit::Item.new(position: 1, price: 10)
    assert_raises(NoMethodError) { @item.position = 3 }
  end

  def tests_can_read_position
    @item = StoreCredit::Item.new(position: 1, price: 10)
    assert_equal(@item.position, 1)
  end

  def tests_ensure_price_is_immutable
    @item = StoreCredit::Item.new(position: 1, price: 10)
    assert_raises(NoMethodError) { @item.price = 20  }
  end

  def tests_can_read_price
    @item = StoreCredit::Item.new(position: 1, price: 10)
    assert_equal(@item.price, 10)
  end

  def test_item_raises_argument_error_if_position_not_given
    assert_raises(ArgumentError) { @item = StoreCredit::Item.new(price: 10)  }
  end

  def test_item_raises_argument_error_if_price_not_given
    assert_raises(ArgumentError) { @item = StoreCredit::Item.new(position: 1)  }
  end
end
