module StoreCredit
  class Store
  
    def initialize()
      @items = []
      @first_item_hash = nil
    end

    def add_item(item)
      if @items.count == 0
        @first_item_hash = item.hash
      end
      @items << item
      #sort_items
    end

    def shift_item
      item = @items.shift
      #sort_items
      item
    end

    def item_count
      @items.count
    end

    def items_empty?
      @items.empty?
    end

    def get_first_item_hash
      @first_item_hash
    end

    private
    def sort_items
      @sorted_items = @items
      @sorted_items.sort! { |a,b| a.price <=> b.price }
    end
  end
end
