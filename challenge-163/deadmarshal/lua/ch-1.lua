function sum_bitwise_operator(t)
   assert(type(t) == 'table', 't must be a table!')
   local sum = 0
   for i=1, #t do
      for j=i+1, #t do
	 sum = sum + (t[i] & t[j])
      end
   end
   return sum
end

local t = {1,2,3}
local t2 = {2,3,4}
print(sum_bitwise_operator(t))
print(sum_bitwise_operator(t2))

