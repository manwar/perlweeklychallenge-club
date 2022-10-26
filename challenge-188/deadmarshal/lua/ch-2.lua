local function total_zero(x,y)
  assert(type(x) == 'number' and type(y) == 'number',
	 'x,y must be numbers!')
  local count = 0
  while x > 0 and y > 0 do
    if x >= y then x = x - y else y = y - x end
    count = count + 1
  end
  return count
end

print(total_zero(5,4));
print(total_zero(4,6));
print(total_zero(2,5));
print(total_zero(3,1));
print(total_zero(7,4));
