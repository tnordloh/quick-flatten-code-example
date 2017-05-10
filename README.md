Implemented in Ruby, the language I'm most familiar with.

Normally, I wouldn't write so much about a task like this, but I want to do my
best to give you a snapshot of how I think about production code.

I'm learning Elixir right now, so the pattern of this code is inspired by that 
experience. In place of guard clauses to control the recursion, I'm using 
if/then/else.  Since the problem description says I should be flattening an array
of integers specifically, I'm choosing to raise an error on anything other than 
`Integer` or `Array`.  This is an arbitrary choice for the moment.  In production 
code, I'd try to discover, among other things, whether we even need to raise an
error, whether a non-integer value matters, and if an unexpected value should be
fed into the logging system.  But, at this point, I'm starting to go down an
error-checking rabbit hole.  If I weren't trying to showcase my ability to
consider potential errors, I would do my best to ensure that a method like this
stays generic, and do error checking of incoming values at their entry point.
Testing incoming data at the moment it is introduced can do a lot to reduce code
complexity in more generic methods like this, and I think, can help ensure that
data transformation logic doesn't get intermixed data validation logic.

If there were no need for catching exceptions, the if/elsif/end logic in 
`ArrayTool.flatten` could be compacted down to a beautiful 1-liner, like this:
```ruby
list.each_with_object(acc) do |item,acc|
  item.is_a?(Array) ? flatten(item,acc) : acc << item
end
```
Since this example is Elixir-inspired, I want to mention that the recursion here
creates a higher load on the stack than you would see in an Elixir implementation
using tail-call recursion.  I'm trading code clarity for a performance hit.  If 
this method were to see a very deeply nested array, it would buckle under the 
weight far sooner than a similarly constructed Elixir implementation. In the
citrus_byte_test.rb, this vulnerability is demonstrated.  So, for the sake of
completeness, check out the very rough non-recursive solution,  below, which
passes all of the current tests (except the one expecting the stack error).
Obviously, this code represents a trade-off.  It's a lot tougher to read, and
generally a little uglier.  But it can handle much deeper nesting.
```ruby
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
```
