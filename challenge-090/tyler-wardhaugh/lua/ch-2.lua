#!/usr/bin/env lua

local t2 = {}

function t2.ethiopian_multiply(a, b)
  local product = 0

  while a > 0 do
    if a % 2 ~= 0 then
      product = product + b
    end

    a = a // 2
    b = b * 2
  end

  return product
end

function t2.run(args)
  local A = tonumber(args[1]) or 12
  local B = tonumber(args[2]) or 14
  local product = t2.ethiopian_multiply(A, B)
  print(product)
end

return t2
