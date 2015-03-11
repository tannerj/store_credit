module StoreCredit
  class Store
    attr_reader :items

    def initialize()
      @items = {}
    end

    def add_item(item)
      @items[item.position] = item
    end

    def remove_item(item={})
      item = @items.delete item[:position]
    end
  end
end
