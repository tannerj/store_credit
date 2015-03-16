module StoreCredit
  class Case
    attr_reader :id, :matched_items_positions
    
    def initialize(id)
      @id = id
      @matched_items_positions = []
    end

    def add_matched_items(items)
      @matched_items_positions = items.sort!
    end
  end
end
