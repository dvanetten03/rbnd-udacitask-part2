class TodoItem
  include Listable
  attr_reader :description, :due, :type, :priority
  

  def initialize(type, description, options={})
    @type = "todo"
    @description = description
    # @priority = priority
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    # set_priority(options[:priority])
  end

  def details
    format_description(@description) + "due: " +
    format_date +
    format_priority(@priority)
  end

  # def priority(priority)
  #   set_priority(priority)
  # end

  # private
  # def set_priority(priority)
  #   raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!" unless @priority = /"high"|"medium"|"low"/ || ""
  #   @priority = priority
  # end
end
