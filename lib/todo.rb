class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type
  attr_accessor :completed

  def initialize(type, description, options={})
    @type = "todo"
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @completed = false
    @priority = options[:priority]
  end

  def details
    format_description(@description) + "due: " +
    format_date +
    format_priority(@priority)
  end
end
