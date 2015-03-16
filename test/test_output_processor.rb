require 'test/unit'
require 'ostruct'
require_relative '../lib/store_credit/output_processor'

class TestOutputProcessor < Test::Unit::TestCase
  def tests_can_instantiate_output_processor
    @output_processor = StoreCredit::OutputProcessor.new
  end

  def tests_can_add_cases_to_output_processor
    @output_processor = StoreCredit::OutputProcessor.new
    @items = [
      @item_1 = OpenStruct.new(position: 1, price: 25),
      @item_2 = OpenStruct.new(position: 2, price: 30),
    ]
    @case = OpenStruct.new(id: 1, matched_items: @items)
    assert_equal(1, @output_processor.add_case(@case))
  end
end
