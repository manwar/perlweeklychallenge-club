local function twice_largest(t)
  table.sort(t, function(a,b) return a > b end)
  if t[1] >= 2 * t[2] then return 1 end
  return -1
end

print(string.format("%2d", twice_largest({1,2,3,4})))
print(string.format("%2d", twice_largest({1,2,0,5})))
print(string.format("%2d", twice_largest({2,6,3,1})))
print(string.format("%2d", twice_largest({4,5,2,3})))

