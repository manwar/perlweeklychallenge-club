#!/usr/bin/env lua

local t2 = {}

function t2.interleave_string(a, b, c)
  if a:len() == 0 then return b == c end
  if b:len() == 0 then return a == c end
  if c:len() ~= a:len() + b:len() then return end

  -- get heads (1st char) and tails (the rest)
  local ah, at = a:match("^(%a)(%a*)$")
  local bh, bt = b:match("^(%a)(%a*)$")
  local ch, ct = c:match("^(%a)(%a*)$")

  return ((ah == ch) and t2.interleave_string(at, b, ct))
      or ((bh == ch) and t2.interleave_string(a, bt, ct))
end

function t2.run(args)
  if #args ~= 3 then
    io.stderr:write("error: must supply three strings\n")
    os.exit(2)
  end

  local a, b, c = table.unpack(args, 1, 3)
  local result = t2.interleave_string(a, b, c)
  if result then print(1) else print(0) end
end

return t2
