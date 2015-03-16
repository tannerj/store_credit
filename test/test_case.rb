require 'test/unit'
require_relative '../lib/store_credit/case'

class TestCase < Test::Unit::TestCase
  def tests_can_init_case
    @case = StoreCredit::Case.new(1)
  end

  def tests_can_read_case_id
    @case = StoreCredit::Case.new(1)
    assert_equal(@case.id, 1)
  end

  def tests_can_adding_matches_sorts_them
    @case = StoreCredit::Case.new(1)
    @case.add_matched_items([2,1])
    assert_equal([1,2], @case.matched_items_positions)
  end
end
