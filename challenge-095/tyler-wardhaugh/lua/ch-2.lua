#!/usr/bin/env lua

--[[ Stack class ]]--
Stack = {}
Stack.__index = Stack

function Stack:new()
  local stack = {}
  setmetatable(stack, Stack)
  stack.stack = {}
  return stack
end

function Stack:push(x)
  table.insert(self.stack, x)
end

function Stack:pop()
  return table.remove(self.stack, #self.stack)
end

function Stack:top()
  return self.stack[#self.stack]
end

function Stack:min()
  local min = self.stack[1]
  for _, v in ipairs(self.stack) do
    if v < min then min = v end
  end
  return min
end

function Stack:print(sep)
  sep = sep or ' '
  print(table.concat(self.stack, sep))
end

--[[ Usage ]]--
local t2 = {}

function t2.demostack()
  local stack = Stack:new()
  stack:push(2)
  stack:push(-1)
  stack:push(0)
  stack:pop()
  print(stack:top())
  stack:push(0)
  print(stack:min())
end

function t2.run(_)
  print("Running stack demo:")
  t2.demostack()
end

return t2
