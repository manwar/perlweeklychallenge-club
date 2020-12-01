#!/usr/bin/env lua

local t1 = {}

function t1.array_of_product(coll)
  local product = 1
  for i=2,#coll do product = product * coll[i] end

  local result = {product}
  for i=2,#coll do
    product = product // coll[i] * coll[i-1]
    table.insert(result, product)
  end
  return result
end

function t1.run(arg)
  local N = {}
  for _, v in ipairs(arg) do table.insert(N, tonumber(v)) end

  M = t1.array_of_product(N)

  io.write('@M = ( ')
  io.write(table.concat(M, ', '))
  print(' )\n')

  for i, v in ipairs(M) do
    io.write('$M[' .. i-1 .. '] = ')
    local temp = {}
    for j, vv in ipairs(N) do
      if j ~= i then
        table.insert(temp, vv)
      end
    end
    io.write(table.concat(temp, ' x '))
    print(' = ' .. v)
  end
end

return t1
