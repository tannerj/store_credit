module StoreCredit
  class OutputProcessor
    
    def initialize()
      @cases = []
    end

    def add_case(new_case)
      @cases << new_case
      new_case.id
    end

    def process
      File.open("/Users/tanner/Desktop/output", "w") do |file|
        @cases.each do |current_case|
          file.puts "Case ##{current_case.id}: #{current_case.matched_items[0].position} #{current_case.matched_items[1].position}"
        end
      end
    end
  end
end
