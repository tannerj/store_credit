module StoreCredit
  class Item
    attr_reader :position, :price
    def initialize(properties={})
      raise ArgumentError if properties[:position] == nil || properties[:price] == nil
      @position = properties[:position]
      @price = properties[:price]
    end
  end
end
