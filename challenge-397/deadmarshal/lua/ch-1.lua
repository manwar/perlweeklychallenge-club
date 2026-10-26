#!usr/local/env lua

local function absent_smallest_positive(t)
  assert(type(t) == 'table','t must be a table!')
  local h,sum = {},0
  for _,e in ipairs(t) do
    h[e] = true
    sum = sum + e
  end
  local q = sum // #t
  if sum < 0 and sum % #t ~= 0 then q = q + 1 end
  local ret = math.max(1,q+1)
  while h[ret] do ret = ret + 1 end
  return ret
end

print(absent_smallest_positive({1,2,4,5,6}))
print(absent_smallest_positive({-5,-2,-1,3}))
print(absent_smallest_positive({1,3,2}))
print(absent_smallest_positive({2,3,7,8}))
print(absent_smallest_positive({1,1,1,10}))

