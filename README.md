I implemented this in Ruby, because that is the language I'm most familiar with.

Also, normally, I wouldn't write so much about a task like this, but I 
want to do my best to give you a snapshot of how I think about production code.

I'm learning Elixir right now, so the pattern of this code is inspired by that 
experience. In place of guard clauses to control the recursion, I'm using 
if/then/else.  Since the problem description says I should be flattening an array of
integers specifically, I'm choosing to catch anything other than `Integer` or `Array`,
to raise an error.  This is an arbitrary choice for the moment.  In production code, 
I'd try to discover, among other things, whether we even need to raise an error, 
whether a non-integer value matters, and if an unexpected value should be fed into the
logging system.  But, at this point, I'm starting to go down an error-checking rabbit
hole.  If I weren't trying to showcase my ability to write tests, and to consider
potential errors, I would do my best to ensure that a method like this stays generic,
and do error checking of incoming values at their entry point.  Testing incoming
data at the moment it is introduced can do a lot to reduce code complexity in
more generic methods like this, and I think, can help ensure that data transformation
logic doesn't get intermixed data validation logic.

If there were no need for catching exceptions, the if/elsif/end logic in 
`ArrayTool.flatten` could be compacted down to a beautiful 1-liner, like this:
```ruby
list.each_with_object(acc) do |item,acc|
  item.class == Array ? flatten(item,acc) : acc << item
end
```

