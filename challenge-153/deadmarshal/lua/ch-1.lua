local function factorial(n)
   assert(type(n) == "number", "n should be a number!")
   if n == 0 then return 1 else return n * factorial(n-1) end
end

local function left_factorial(n)
   assert(type(n) == "number", "n should be a number!")
   local sum = 0
   for i=0, n-1 do
      sum = sum + factorial(i)
   end
   return sum
end

for i=1, 10 do io.write(left_factorial(i), ' ') end

