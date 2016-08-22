module UdaciListErrors
  #Error classes go here
  def InvalidItemTypeError < StandardError
  end

  def IndexExceedsListSizeError < StandardError
  end

  def InvalidPriorityValueError < StandardError
  end

end
