function is_prime(n)
   assert(type(n) == 'number', 'n must be a number!')
   if n <= 1 then return false end
   for i=2,math.sqrt(n) do
      if n % i == 0 then return false end
   end
   return true
end

function reverse(n)
   assert(type(n) == 'number', 'n must be a number!')
   local rev = 0
   while n ~= 0 do
      rev = (rev * 10) + (n % 10)
      n = n // 10
   end
   return rev
end

for i=1, 1000 do
   if i == reverse(i) and is_prime(i) then
      io.write(i, ' ')
   end
end
