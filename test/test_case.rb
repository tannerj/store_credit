require 'test/unit'
require 'ostruct'
require_relative '../lib/store_credit/case'

class TestCase < Test::Unit::TestCase
  def tests_can_init_case
    @case = StoreCredit::Case.new(1)
  end

  def tests_can_read_case_id
    @case = StoreCredit::Case.new(1)
    assert_equal(@case.id, 1)
  end

  def tests_adding_matches_sorts_them
    @case = StoreCredit::Case.new(1)
    @items = [
      @item_1 = OpenStruct.new(position: 4, price: 25),
      @item_2 = OpenStruct.new(position: 1, price: 100)
    ]
    @case.add_matched_items(@items)
    assert_equal([@item_2, @item_1], @case.matched_items)
  end
end
