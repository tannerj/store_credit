module StoreCredit
  class InputProcessor
    attr_reader :input
    def initialize(input_file)
      @input_file = input_file
      @number_of_cases = nil
      @cases_processed = 0
    end

    def process
      @number_of_cases = @input_file.file.readline.to_i
      while !@input_file.file.eof?
        balance = @input_file.file.readline.to_i
        item_count = @input_file.file.readline.to_i
        items = @input_file.file.readline.split(" ").map!{ |i| i.to_i}
        case_number = @cases_processed + 1
        yield case_number, balance, item_count, items
        @cases_processed += 1
      end
    end
  end
end
