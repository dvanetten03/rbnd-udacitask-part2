module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_priority(priority)
    value = " ⇧".bold.red if priority == "high"
    value = " ⇨".bold.white if priority == "medium"
    value = " ⇩".bold.blue if priority == "low"
    value = "" if !priority
    return value
  end  
    
  def format_date(options={})
    if @type == "event"
      dates = start_date.strftime("%D").colorize(:green) if start_date
      dates << " -- " + end_date.strftime("%D").colorize(:white) if end_date
      dates = "N/A".colorize(:yellow) if !dates
      return dates
    else
      @due ? @due.strftime("%D").colorize(:red) : "None"
    end
  end
end
