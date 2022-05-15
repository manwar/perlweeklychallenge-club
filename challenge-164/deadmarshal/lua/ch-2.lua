function sum_squares(n)
   assert(type(n) == 'number', 'n must be a number!')
   local sum = 0
   while n ~= 0 do
      sum = sum + (n % 10)^2
      n = n // 10
   end
   return sum
end

function is_happy(n)
   assert(type(n) == 'number', 'n must be a number!')
   local t = {}
   while true do
      t[n] = 1
      n = sum_squares(n)
      if n == 1 then return true end
      if t[n] ~= nil then return false end
   end
end

function happy_numbers()
   local i,count = 0,0
   while count < 8 do
      if is_happy(i) then io.write(i, ' ') count = count + 1 end
      i = i + 1
   end
end

happy_numbers();
