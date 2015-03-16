module StoreCredit
  class Store
    attr_reader :items   
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
        @next_item_index += 1
      else
        nil
      end
    end

    def find_item_by_price(price)
      @items.each do |item|
        return item if item.price == price
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
