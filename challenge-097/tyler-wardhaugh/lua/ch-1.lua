#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = {'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG', 3}

function t1.caesar(s, n)
  local aleph = ('A'):byte()
  local zed = ('Z'):byte()
  local diff = zed - aleph

  local cipher = {}
  local c
  for i = aleph, zed do
    c = i - n
    if c < aleph then c = c + diff + 1 end
    cipher[string.char(i)] = string.char(c)
  end

  return s:gsub('.', cipher)
end

function t1.run(args)
  local s, n
  if #args > 0 then
    s, n = args[1], tonumber(args[2])
  else
    s, n = table.unpack(t1.DEFAULT_INPUT)
  end

  print('Plaintext:  ' .. s)
  print('Ciphertext: ' .. t1.caesar(s, n))
end

return t1
