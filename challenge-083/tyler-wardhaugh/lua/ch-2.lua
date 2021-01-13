#!/usr/bin/env lua

local t2 = {}

function t2.flip_array(coll)
  local min_flips = math.maxinteger
  local min_sum = math.maxinteger
  local max_bits = 2^#coll - 1

  local cur_num, cur_sum, is_neg
  for bits = 1, max_bits do
    cur_num, cur_sum, is_neg = 0, 0, 0
    for i, v in ipairs(coll) do
      is_neg = bits & 2^(i-1) == 0
      cur_num = cur_num + (is_neg and 1 or 0)
      cur_sum = cur_sum + v * (is_neg and -1 or 1)
    end

    if 0 <= cur_sum and cur_sum <= min_sum then
        min_flips = math.min(cur_num, min_flips)
        min_sum = cur_sum
    end
  end

  return min_flips
end


function t2.run(args)
  local minimum = t2.flip_array(args)
  print(minimum)
end

return t2
