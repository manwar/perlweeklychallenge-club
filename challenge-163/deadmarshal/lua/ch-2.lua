function summations(t)
   assert(type(t) == 'table', 't must be a table!')
   for i=1, #t do
      for j=i+1, #t-1 do
	 t[j+1] = t[j] + t[j+1]
      end
   end
   return t[#t]
end

local t = {1,2,3,4,5}
local t2 = {1,3,5,7,9}
print(summations(t))
print(summations(t2))

