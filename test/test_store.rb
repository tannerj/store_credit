require_relative '../lib/store_credit/store'
require 'ostruct'
require 'test/unit'

class TestStore < Test::Unit::TestCase
  
  def tests_store_con_be_initialized
    @store = StoreCredit::Store.new
  end

  def tests_items_empty_returns_zero_with_no_items
    @store = StoreCredit::Store.new
    assert_equal(true, @store.items_empty?)
  end

  def tests_item_count_returns_zero_when_no_items_in_store
    @store = StoreCredit::Store.new
    assert_equal(0, @store.item_count)
  end

  def tests_can_stock_items
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    assert_equal(3, @store.item_count)
  end

  def tests_stock_sorts_items
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 30),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 10)
    ]
    @store.stock(@items)
    assert_equal(@item_3, @store.checkout_next_item)
    @store.return_checked_out_item
    assert_equal(@item_2, @store.checkout_next_item)
    @store.return_checked_out_item
    assert_equal(@item_1, @store.checkout_next_item)
  end

  def tests_can_checkout_next_item
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    assert_equal(@item_1, @store.checkout_next_item)
  end

  def tests_checkout_next_item_returns_nil_when_next_item_index_out_of_bounds
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    3.times do
      @store.checkout_next_item
      @store.return_checked_out_item
    end
    assert_equal(nil, @store.checkout_next_item)
  end

  def tests_can_return_checked_out_item
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    @store.checkout_next_item
    assert_equal(0, @store.return_checked_out_item)
  end

  def tests_return_checked_out_item_increments_next_item_index
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    @store.checkout_next_item
    @store.return_checked_out_item
    assert_equal(@item_2, @store.checkout_next_item)
  end

  def tests_return_checked_out_item_returns_nil_when_no_item_checked_out
    @store = StoreCredit::Store.new
    assert_equal(nil, @store.return_checked_out_item)
  end

  def tests_return_checked_out_item_returns_nil_when_next_item_index_out_of_bounds
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    3.times do
      @store.checkout_next_item
      @store.return_checked_out_item
      @store.checkout_next_item
    end
    assert_equal(nil, @store.return_checked_out_item)
  end

  def tests_find_item_by_price_returns_correct_item
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    assert_equal(@item_2, @store.find_item_by_price(20))
  end

  def tests_find_item_by_price_returns_false_on_item_miss
    @store = StoreCredit::Store.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 10),
      @item_2 = OpenStruct.new(position: 2, price: 20),
      @item_3 = OpenStruct.new(position: 3, price: 30)
    ]
    @store.stock(@items)
    assert_equal(false, @store.find_item_by_price(40))
  end
end
