require_relative '../lib/store_credit/store'
require 'ostruct'
require 'test/unit'

class TestStore < Test::Unit::TestCase
  def tests_store_con_be_initialized
    @store = StoreCredit::Store.new
  end
  
  def tests_can_add_item_to_items
    @store = StoreCredit::Store.new
    @item = OpenStruct.new(position: 1, price: 10)
    assert_equal(@store.item_count, 0)
    @store.add_item(@item)
    assert_equal(@store.item_count, 1)
  end

  def tests_first_item_hash_is_first_item_hash
    @store = StoreCredit::Store.new
    @item = OpenStruct.new(position: 100, price: 2000)
    @store.add_item(@item)
    @store = add_items_to_store(@store, 20)
    assert_equal(@item.hash, @store.get_first_item_hash) 
  end

  def tests_first_item_hash_is_updated_after__items_emptied
    @store = StoreCredit::Store.new
    @item = OpenStruct.new(position: 100, price: 2000)
    @store.add_item(@item)
    @store = add_items_to_store(@store, 20)
    #empty @store
    @store.shift_item until @store.items_empty?
    @new_item = OpenStruct.new(position: 1001, price: 2001)
    @store.add_item(@new_item)
    assert_equal(@new_item.hash, @store.get_first_item_hash)
  end

  def tests_can_shift_item_off_items_stack
    @store = StoreCredit::Store.new
    @store = add_items_to_store(@store, 20)
    assert_match(/#<OpenStruct position=\d+, price=\d+>/, @store.shift_item.to_s)
  end

  def add_items_to_store(store, number_of_items)
    number_of_items.times do |i|
      i += 1
      item = OpenStruct.new(position: i, price: i*10)
      store.add_item(item)
    end
    store
  end
end
