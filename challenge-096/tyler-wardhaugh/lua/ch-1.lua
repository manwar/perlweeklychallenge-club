#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = 'The Weekly Challenge'

function t1.reverse_words(s)
  local words = {}
  for word in s:gmatch('%S+') do
    table.insert(words, 1, word)
  end
  return table.concat(words, ' ')
end

function t1.run(args)
  local s
  if #args > 0 then
    s = args[1]
  else
    s = t1.DEFAULT_INPUT
  end

  print(t1.reverse_words(s))
end

return t1
