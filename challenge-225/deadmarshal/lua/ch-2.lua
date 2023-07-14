#!/usr/bin/env lua

local function left_right_sum_diff(t)
  local left,right = 0,0
  for i=2,#t do right = right + t[i] end
  for i=1,#t do
    io.write(math.abs(left - right), ' ')
    left = left + t[i]
    if i < #t then right = right - t[i+1] end
  end
  print()
end

left_right_sum_diff({10,4,8,3})
left_right_sum_diff({1})
left_right_sum_diff({1,2,3,4,5})

