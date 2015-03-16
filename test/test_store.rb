require_relative '../lib/store_credit/store'
require 'ostruct'
require 'test/unit'

class TestStore < Test::Unit::TestCase
  def tests_store_con_be_initialized
    @store = StoreCredit::Store.new
  end

  def tests_can_stock_items
    @store = StoreCredit::Store.new
    @items = get_three_item_array
    puts @items
    @store.stock(@items)
    assert_equal(3, @store.item_count)
  end

  def tests_can_checkout_next_item
    @store = StoreCredit::Store.new
    @items = get_three_item_array
    @store.stock(@items)
    assert_equal(@items[1], @store.checkout_next_item)
  end

  def tests_checkout_next_item_returns_nil_when_next_item_index_out_of_bounds
    @store = StoreCredit::Store.new
    @items = get_three_item_array
    @store.stock(@items)
    3.times do
      @store.checkout_next_item
      @store.return_checked_out_item
    end
    assert_equal(nil, @store.checkout_next_item)
  end

  def tests_can_return_checked_out_item
    @store = StoreCredit::Store.new
    @items = get_three_item_array
    @store.stock(@items)
    items = @store.items
    @store.checkout_next_item
    @store.return_checked_out_item
    assert_equal(items, @store.items)
  end

  def tests_return_checked_out_item_increments_next_item_index
    @store = StoreCredit::Store.new
    @items = get_three_item_array
    @store.stock(@items)
    @store.checkout_next_item
    assert_equal(1, @store.return_checked_out_item)
  end

  def tests_return_checked_out_item_returns_nil_when_no_item_checked_out
    @store = StoreCredit::Store.new
    assert_equal(nil, @store.return_checked_out_item)
  end

  def tests_return_checked_out_item_returns_nil_when_next_item_index_out_of_bounds
    @store = StoreCredit::Store.new
    @items = get_three_item_array
    @store.stock(@items)
    3.times do
      @store.checkout_next_item
      @store.return_checked_out_item
      @store.checkout_next_item
    end
    assert_equal(nil, @store.return_checked_out_item)
  end

  def get_three_item_array
    items = [
      item_1 = OpenStruct.new(position: 1, price: 20),
      item_2 = OpenStruct.new(position: 2, price: 10),
      item_3 = OpenStruct.new(position: 3, price: 12)
    ]
    items
  end
end
