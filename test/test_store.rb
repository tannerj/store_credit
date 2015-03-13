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
  
  def tests_lasts_item_hash_is_nil_when_no_items_in_store
    @store = StoreCredit::Store.new
    assert_equal(nil, @store.last_item_hash)
  end

  def tests_last_item_hash_is_updated_on_add_item
    @store = StoreCredit::Store.new
    @item = OpenStruct.new(position: 1, price: 10)
    @store.add_item(@item)
    assert_equal(@store.last_item_hash, @item.hash)
  end

  def tests_last_item_hash_is_updated_after_removing_last_item
    @store = StoreCredit::Store.new
    @item = OpenStruct.new(postiion: 1, price: 10)
    @item_2 = OpenStruct.new(postiion: 2, price: 20)
    @store.add_item(@item)
    @store.add_item(@item_2)
    item = @store.remove_next_item
    @store.restore_current_item(item)
    @store.remove_next_item
    assert_equal(@store.last_item_hash, @item.hash)
  end

  def tests_last_item_hash_is_set_to_nil_when_store_items_emptied
    @store = StoreCredit::Store.new
    add_items_to_store(@store, 20)
    @store.remove_next_item until @store.items_empty?
    assert_equal(nil, @store.last_item_hash)
  end

  def tests_can_remove_next_item
    @store = StoreCredit::Store.new
    add_items_to_store(@store, 20)
    assert_match(/#<OpenStruct position=\d+, price=\d+>/, @store.remove_next_item.to_s)
  end

  def tests_adding_items_sorts_the_items
    @store = StoreCredit::Store.new
    @item_1 = OpenStruct.new(position: 1, price: 23)
    @item_2 = OpenStruct.new(position: 2, price: 10)
    @item_3 = OpenStruct.new(position: 3, price: 15)
    @store.add_item(@item_1)
    @store.add_item(@item_2)
    @store.add_item(@item_3)
    assert_equal(@item_2, @store.remove_next_item)
    assert_equal(@item_3, @store.remove_next_item)
    assert_equal(@item_1, @store.remove_next_item)
  end

  def tests_can_find_item_by_price
    @store = StoreCredit::Store.new
    add_items_to_store(@store, 20)
    @item = @store.find_item_by_price(30)
    assert_equal(3, @item.position)
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
