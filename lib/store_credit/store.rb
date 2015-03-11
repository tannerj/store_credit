module StoreCredit
  class Store
  
    def initialize()
      @items = []
    end

    def add_item(item)
      @items << item
    end

    def remove_item(item_properties={})
      @items.delete_if { |item| item.position == item_properties[:position] }
    end

    def item_count
      @items.count
    end
  end
end
