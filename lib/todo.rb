class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(type, description, options={})
    @type = "todo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = priority
  end

  # def priority
  #   unless priority =~ /high|medium|low/ || !priority
  #     raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!"
  #   end
  #   @items[index - 1].priority = priority
  # end

  def details
    format_description(@description) + "due: " +
    format_date +
    format_priority(@priority)
  end
end
