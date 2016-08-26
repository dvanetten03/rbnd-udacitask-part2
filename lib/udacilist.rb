class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? @title = options[:title] : @title = "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
      raise UdaciListErrors::InvalidItemTypeError, "Sorry, that is not one of the list types, try again, or create a new list type!" unless type =~ /todo|event|link/
        @items.push TodoItem.new(type, description, options) if type == "todo"
        @items.push EventItem.new(type, description, options) if type == "event"
        @items.push LinkItem.new(type, description, options) if type == "link" 
  end
 

  def delete(index)
    raise UdaciListErrors::IndexExceedsListSizeError, "You don't have that many items on the list" if index >= items.count
  
    @items.delete_at(index - 1)
  end

  def priority(index, priority)
    unless priority =~ /high|medium|low/ || !priority
      raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!"
    end
    @items[index - 1].priority = priority
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
    table.style = {:padding_left => 3, :border_x => "=", :border_i => "x"}
    puts table
  end
end
