class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @priority = priority
    @type = "todo"
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    if options[:priority] =~ /high|medium|low/ || !priority
      @priority = (options[:priority])
    else
      raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!"
    end  
  end

  def details
    format_description(@description) + "due: " +
    format_date + " priority: " +
    format_priority(@priority) + " item_type: " + @type
  end

  # def change_due_date date
  #   @due = Chronic.parse(date)
  # end
end