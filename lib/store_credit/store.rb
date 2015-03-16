module StoreCredit
  class Store
    def initialize()
      @items = []
      @next_item_index = 0
      @current_checked_out_item = nil
    end

    def stock(items)
      items.each { |item| @items << item }
      sort_items
    end

    def checkout_next_item
      return nil if @items == nil
      if @next_item_index < @items.count
        @current_checked_out_item = @items.delete_at(@next_item_index)
      else
        nil
      end
    end

    def return_checked_out_item
      if @current_checked_out_item
        @items.insert(@next_item_index, @current_checked_out_item)
        @current_checked_out_item = nil
        old_next_item_index = @next_item_index
        @next_item_index += 1
        old_next_item_index
      else
        nil
      end
    end

   def find_item_by_price(price)
     min = 0
     max = @items.length - 1
     mid = min + ((max - min) / 2)
     while min <= max
       return @items[mid] if @items[mid].price == price
       min = mid + 1 if price > @items[mid].price
       max = mid - 1 if price < @items[mid].price
       mid = min + ((max - min) / 2)
     end
     false
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
