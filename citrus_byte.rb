module ArrayTool

  module_function
  
  def flatten(list)
    until list.all? { |item| item.is_a?(Integer) } || list == []
      list = flatten_one_level(list)
    end
    list
  end

  def flatten_one_level(list)
    list.each_with_object([]) do |item,acc|
      if item.is_a?(Array)
        item.each {|sub_item| acc << sub_item }
      elsif item.is_a?(Integer)
        acc << item
      else
        raise ArgumentError, "non-integer value found: #{item.class}"
      end
    end
  end

end
