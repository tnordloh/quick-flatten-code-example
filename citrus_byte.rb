module ArrayTool

  module_function
  
  def flatten(list,acc = [])
    list.each_with_object(acc) do |item,acc|
      case item.kind_of?
      when Array
        flatten(item,acc)
      when Integer
        acc << item
      else
        raise ArgumentError, "non-integer value found: #{item.class}"
      end
    end
  end

end
