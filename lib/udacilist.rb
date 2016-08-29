class UdaciList
  attr_reader :title, :items, :priority

  def initialize(options={})
    @title = options[:title] ? @title = options[:title].bold.yellow : @title = "Untitled List".bold.yellow
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    @priority = priority
    raise UdaciListErrors::InvalidItemTypeError, "Sorry, that is not one of the list types, try again, or create a new list type!".bold.red unless type =~ /todo|event|link/
      @items.push TodoItem.new(description, options) if type == "todo"
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link" 
  end
 
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSizeError, "You don't have that many items on the list, you need to check yourself!".bold.red if index >= items.count
    @items.delete_at(index - 1)
  end

  def filter(type)
    filtered_item = items_by_type(type)
    filtered_item.each_with_index do |item, position|
      puts "#{position + 1} #{item_details}"
    end
    if filtered_item.length == 0
      puts "There are no '#{type}' items! "
    end
  end

  def items_by_type(type)
     @items.select {|i| i.type == type}
  end

  def all
    rows = []
    @items.each_with_index do |item, position|
      rows << [position+1, item.details]
    end
    table = Terminal::Table.new :title => @title, :rows => rows, headings: %w(Id Item)
    table.style = {:padding_left => 2, :border_x => "=", :border_i => "x"}
    puts table
  end

  # def delete(index)
  #   if index-1 > @items.length
  #     raise UdaciListErrors::IndexExceedsListSizeError.new "Index #{index} exceeds List Size."
  #   end
  #   @items.delete_at(index - 1)
  # end
  
  # def delete_many(*indexes)
  #   indexes.sort.reverse.each {|i| delete(i)}
  # end

  # def all
  #   puts "-" * @title.length
  #   puts @title
  #   puts "-" * @title.length
  #   @items.each_with_index do |item, position|
  #     puts "#{position + 1}) #{item.details}"
  #   end
  # end

  # def filter(type)
  #   result = @items.select {|item| item.type == type.downcase}
  #   result.each {|item| puts item.details}
  #   result
  # end

  # def pretty_output
  #   rows = []
  #   rows << ["?", "#", "Details"]
  #   rows << [" ", " ", " "]
  #   @items.each_with_index do |item, position|
  #     rows << ["_", position + 1, item.details]
  #   end
  #   table = Terminal::Table.new :rows => rows
  #   puts table
  # end

  # def change_due_date(index, due_date)
  #   @items[index-1].change_due_date(due_date) if @items[index-1].instance_variable_defined?(:@due)
  # end
end

#   def priority(index, priority)
#     unless priority =~ /high|medium|low/ || !priority
#       raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!"
#     end
#     @items[index - 1].priority = priority
#   end
