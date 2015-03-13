module StoreCredit
  class Store
   
    attr_reader :last_item_hash

    def initialize()
      @items = []
      @last_item_hash = nil
      @next_item_index = 0
    end

    def add_item(item)
      @items << item
      sort_items
      @last_item_hash = @items.last.hash
    end

    def remove_next_item
      return nil if @items.empty? 
      item = @items.delete_at(@next_item_index)
      sort_items
      if @items.last != nil
        @last_item_hash = @items.last.hash
      else
        @last_item_hash = nil
      end
      item
    end

    def restore_current_item(item_to_restore)
      add_item(item_to_restore)
      @items.each.with_index do |item, index|
        if item.hash == item_to_restore.hash
          if (index + 1) < @items.count
            @next_item_index += 1
          end
        end
      end
    end

    def find_item_by_price(price)
      @items.each do |item|
        return item if item.price == price
      end
    end

    def item_count
      @items.count
    end

    def items_empty?
      @items.empty?
    end

    private
    def sort_items
      @items.sort! { |a,b| a.price <=> b.price }
    end
  end
end
