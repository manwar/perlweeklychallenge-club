function is_prime(n)
   assert(type(n) == "number", "n must be a number!")
   if n <= 1 then return false end
   for i=2, math.sqrt(n) do
      if n % i == 0 then return false end
   end
   return true
end

function sum_digits(n)
   assert(type(n) == "number", "n must be a number!")
   local sum = 0
   while n ~= 0 do
      sum = sum + n % 10
      n = n // 10
   end
   return sum
end

function additive_primes()
   local t = {}
   for i=0, 100 do
      if is_prime(i) and is_prime(sum_digits(i)) then
	 t[#t+1] = i
      end
   end
   return t
end
   
local t = additive_primes()
for i=1, #t do io.write(t[i], ' ') end
