module ArrayTool

  module_function
  
  def flatten(list,acc = [])
    list.each_with_object(acc) do |item,acc|
      if item.is_a?(Array)
        flatten(item,acc)
      elsif item.is_a?(Integer)
        acc << item
      else
        raise ArgumentError, "non-integer value found: #{item.class}"
      end
    end
  end

end
