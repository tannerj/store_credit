module StoreCredit
  class Application
    def run(input_files)
      @input_processor = StoreCredit::InputProcessor.new(input_files)
      @output_processor = StoreCredit::OutputProcessor.new
      @input_processor.process do |case_number, balance, item_count, items|
        @case = StoreCredit::Case.new(case_number)
        @account = StoreCredit::Account.new(balance)
        @store = StoreCredit::Store.new
        @items = create_items(items)
        @store.stock(@items)
        find_item_matches
      end
      @output_processor.process
    end

    private
    def create_items(items)
      item_objects = []
      items.each.with_index do |item, index|
        index += 1
        new_item_object = StoreCredit::Item.new(position: index, price: item)
        item_objects << new_item_object
      end
      item_objects
    end
    
    def find_item_matches
      while item = @store.checkout_next_item
        begin
          @account.withdraw(item.price)
          matched_item = @store.find_item_by_price(@account.balance)
          if matched_item
            @case.add_matched_items([item, matched_item])
            @output_processor.add_case(@case)
            break
          end
          @store.return_checked_out_item
          @account.deposit(item.price)
        rescue StoreCredit::Account::InsufficientFunds
          next
        end
      end
    end

  end
end
