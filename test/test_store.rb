require_relative '../lib/store_credit/store'
require 'test/unit'

class TestStore < Test::Unit::TestCase
  def tests_store_con_be_initialized
    store = StoreCredit::Store.new
  end
  
  def tests_can_add_item_to_items
    store = StoreCredit::Store.new
    @item = {position: 1, price: 10}
    assert_equal(store.items.count, 0)
    store.add_item(@item)
    assert_equal(store.items.count, 1)
  end
end
