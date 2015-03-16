module StoreCredit
  class Case
    attr_reader :id, :matched_items
    
    def initialize(id)
      @id = id
      @matched_items = []
    end

    def add_matched_items(items)
      @matched_items = items.sort! { |a,b| a.position <=> b.position}
    end
  end
end
