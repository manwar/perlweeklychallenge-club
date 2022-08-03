local function has_same_digits(m,n)
   assert(type(m) == 'number' and type(n) == 'number',
	  'm and n must be numbers!')
   local t = {0,0,0,0,0,0,0,0,0,0}
   while m ~= 0 do
      t[(m % 10)+1] = t[(m % 10)+1] + 1
      m = m // 10
   end
   while n ~= 0 do
      t[(n % 10)+1] = t[(n % 10)+1] - 1
      n = n // 10
   end
   for i=1, #t do if t[i] ~= 0 then return false end end
   return true
end
  
local function smallest_permuted_multiples()
   local i = 10
   while true do
      local found = true
      for j=2, 6 do
	 if not has_same_digits(i, i * j) then
	    found = false
	    break
	 end
      end
      if found then return i end
      i = i + 1
   end
end

print(smallest_permuted_multiples())
