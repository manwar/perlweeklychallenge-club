local t2 = {}
t2.DEFAULT_INPUT = {'101100101', 3}

function t2.binary_substrings(bstr, size)
  local parts = {}
  local s, e
  for i = 0, (#bstr // size) - 1 do
    s = (i * size) + 1
    e = s + size - 1
    table.insert(parts, bstr:sub(s, e))
  end

  local sum = 0
  local zeros, ones
  for i = 1, size do
    zeros = 0
    for _, p in ipairs(parts) do
      if p:sub(i, i) == '0' then
        zeros = zeros + 1
      end
    end
    ones = size - zeros
    sum = sum + math.min(zeros, ones)
  end

  return sum
end

function t2.run(args)
  local b, s
  if #args > 0 then
    b, s = args[1], tonumber(args[2])
  else
    b, s = table.unpack(t2.DEFAULT_INPUT)
  end

  print(t2.binary_substrings(b, s))
end

return t2
