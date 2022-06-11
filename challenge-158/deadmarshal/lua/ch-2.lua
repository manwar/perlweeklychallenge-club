function is_prime(n)
   assert(type(n) == "number", "n must be a number!")
   if n <= 1 then return false end
   for i=2, math.sqrt(n) do
      if n % i == 0 then return false end
   end
   return true
end

function cuban_primes(n)
   assert(type(n) == "number", "n must be a number!")
   local t, i = {}, 1
   while i do
      local p = 3 * i * (i + 1) + 1
      if is_prime(p) then t[#t+1] = p end
      if p >= n then break end
      i = i + 1
   end
   return t
end

local t = cuban_primes(1000)
for i=1, #t do io.write(t[i], ' ') end
