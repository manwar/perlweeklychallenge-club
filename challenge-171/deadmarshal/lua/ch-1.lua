local function divisors_sum(n)
   assert(type(n) == 'number', 'n must be a number!')
   if n < 2 then return 0 end
   local sqrt, sum = math.sqrt(n), 0
   for i = 2, sqrt do
      if n % i == 0 then
	 sum = sum + i
	 if i ~= sqrt then sum = sum + (n // i) end
      end
   end
   sum = sum + 1
   return sum
end

local function abundant_odd_numbers()
   local t,i = {},1
   repeat
      if divisors_sum(i) > i and
	 (i % 2) ~= 0 then
	 t[#t+1] = i
      end
      i = i + 1
   until #t == 20
   return t
end

local t = abundant_odd_numbers()
for i=1, #t do
   io.write(t[i], ' ')
end
