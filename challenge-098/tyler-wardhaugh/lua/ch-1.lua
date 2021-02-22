#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = {'../clojure/resources/input.txt', 4}
t1.FILES = {}

function t1.readN(filename, n)
  local fp = t1.FILES[filename] or assert(io.open(filename, "r"))
  local result = fp:read(n)
  t1.FILES[filename] = fp
  return result
end

function t1.run(args)
  local filename, n
  if #args > 0 then
    filename, n = args[1], tonumber(args[2])
  else
    filename, n = table.unpack(t1.DEFAULT_INPUT)
  end

  local result
  for _=1,3 do
    result = t1.readN(filename, n)
    if result ~= nil then
      print(result)
    end
  end
end

return t1
