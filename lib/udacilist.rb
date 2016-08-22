class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    priority = options[:priority]
    if !type =~ /todo|event|link/ 
      raise UdaciListErrors::InvalidItemTypeError, "Sorry, that is not one of the list types, try again, or create a new list type!"
    end
    unless priority == "high" || priority == "medium" || priority == "low" || !priority
      raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!"
    end
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def delete(index)
    if index >=items.count
      raise UdaciListErrors::IndexExceedsListSizeError, "You don't have that many items on the list"
    end
    @items.delete_at(index - 1)
  end

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
