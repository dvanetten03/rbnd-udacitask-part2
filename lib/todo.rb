class TodoItem
  include Listable
  attr_reader :description, :due
  attr_accessor :priority

  def initialize(description, options={})
    priorities = ["high", "medium", "low", nil]
    @description = description
    @priority = options[:priority]
    @type = "todo"
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    unless priorities.include? priority
      raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!".bold.red
    end  
  end

  def details
    format_description(@description).white + "   due: ".blink.magenta +
    format_date+ "    priority: " +
    format_priority(@priority) + "    item_type: ".blue + @type
  end
  
end