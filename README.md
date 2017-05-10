I implemented this in Ruby, because that is the language I'm most familiar with.

The code is fairly straightforward.  I called my method 'flatten', to keep things
as simple, and self-explanatory as possible.

Flatten recreates the array, using each_with_object, and an accumulator.  I'm 
learning Elixir a right now, so the pattern of this code is inspired by that 
experience pretty heavily. In place of guard clauses to control the recursion,
I'm using an if/then/else.  Since the query says that I should be flattening an
array of integers specifically, I'm choosing to catch anything other than
'Integer' or 'Array', to raise an error.  This is an arbitrary choice for the 
moment.  In production code, I'd figure out whether we even need to raise an
error, whether a non-integer value matters, and if an unexpected value here
should be fed into the logging system.

If there were no need for catching exceptions, the if/elsif/end logic in 
`ArrayTool.flatten` could be compacted down to a beautiful 1-liner, like this:
```ruby
list.each_with_object(acc) do |item,acc|
  item.class == Array ? flatten(item,acc) : acc << item
end
```
