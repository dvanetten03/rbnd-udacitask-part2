class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] ? @title = options[:title].bold.yellow : @title = "Untitled List".bold.yellow
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    raise UdaciListErrors::InvalidItemTypeError, "Sorry, that is not one of the list types, try again, or create a new list type!".bold.red unless type =~ /todo|event|link/
      @items.push TodoItem.new(description, options) if type == "todo"
      @items.push EventItem.new(description, options) if type == "event"
      @items.push LinkItem.new(description, options) if type == "link" 
  end
 
  def delete(index)
    raise UdaciListErrors::IndexExceedsListSizeError, "You don't have that many items on the list, you need to check yourself!".bold.red if index >= items.count
    @items.delete_at(index - 1)
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

  def filter(type)
    filtered = @items.select {|i| i.to_s.downcase.include? type.downcase}
    if filtered.empty?
      raise UdaciListErrors::InvalidItemTypeError, "You can't filter by a type that doesn't exist.".bold.red
    end
    unless filtered.empty? 
      puts
      puts
      puts "Filtered by #{type}"
      puts '-------------------'
      filtered.each_with_index do |item, position|
        puts "#{position + 1}) #{item.details}"
      end
    end
  end

end

