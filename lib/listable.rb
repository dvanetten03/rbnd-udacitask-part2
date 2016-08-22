module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_priority(priority)
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

  def format_date(options={})
    due = options[:due] ? Date.parse(options[:due]) : options[:due]
    start_date = Date.parse(options[:start_date]) if options[:start_date]
    end_date = Date.parse(options[:end_date]) if options[:end_date]

    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates

    @due ? @due.strftime("%D") : "No due date"
  end


end
