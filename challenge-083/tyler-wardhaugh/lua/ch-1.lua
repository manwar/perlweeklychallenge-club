#!/usr/bin/env lua

local t1 = {}

function t1.inner_words_length(s)
  local inner = s:match("^%S+%s+%f[%S](.*)%f[%s]%s+%S+$")
  if inner then
    return inner:gsub("%s+", ""):len()
  else
    return 0
  end
end

function t1.run(args)
  local s = args[1]
  local len = t1.inner_words_length(s)
  print(len)
end

return t1
