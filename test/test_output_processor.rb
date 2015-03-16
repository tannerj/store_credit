require 'test/unit'
require_relative '../lib/store_credit/output_processor'

class TestOutputProcessor < Test::Unit::TestCase
  def tests_can_instantiate_output_processor
    @output_processor = StoreCredit::OutputProcessor.new
  end
end
