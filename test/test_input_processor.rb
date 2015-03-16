require 'test/unit'
require_relative '../lib/store_credit/input_processor'

class TestInputProcessor < Test::Unit::TestCase
  def tests_can_instantiate_input_processor
    @input_processor = StoreCredit::InputProcessor.new("test input")
  end
end
