module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_priority(priority)
    value = " ⇧".colorize(:red) if priority == "high"
    value = " ⇨".colorize(:white) if priority == "medium"
    value = " ⇩".colorize(:blue) if priority == "low"
    value = "" if !priority
    return value
    if priority =~ /high|medium|low/ || !priority 
    raise UdaciListErrors::InvalidPriorityValueError, "Please change priority to 'high', 'medium' or 'low'!"
  end
    
  end

  def format_date(options={})
    if self.type == "event"
      dates = start_date.strftime("%D") if start_date
      dates << " -- " + end_date.strftime("%D") if end_date
      dates = "N/A" if !dates
      return dates
    else
      @due ? @due.strftime("%D") : "No due date"
    end
  end
end