require_relative '../lib/store_credit/store'
require 'ostruct'
require 'test/unit'

class TestStore < Test::Unit::TestCase
  def tests_store_con_be_initialized
    store = StoreCredit::Store.new
  end
  
  def tests_can_add_item_to_items
    store = StoreCredit::Store.new
    @item = OpenStruct.new(position: 1, price: 10)
    assert_equal(store.items.count, 0)
    store.add_item(@item)
    assert_equal(store.items.count, 1)
  end

  #Tests that an item can be removed from the item inventory
  #by position number
  def tests_can_remove_item_from_items
    store = StoreCredit::Store.new
    @item = OpenStruct.new(position: 1, price: 10)
    assert_equal(store.items.count, 0)
    store.add_item(@item)
    assert_equal(store.items.count, 1)
    store.remove_item(position: 1)
    assert_equal(store.items.count, 0)
  end
end
