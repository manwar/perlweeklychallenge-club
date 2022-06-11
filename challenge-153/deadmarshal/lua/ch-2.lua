local function digits(n)
   assert(type(n) == "number", "n should be a number!")
   local t = {}
   while n > 0 do
      t[#t+1] = n % 10
      n = n // 10
   end
   return t
end

local function factorial(n)
   assert(type(n) == "number", "n should be a number!")
   if n == 0 then return 1 else return n * factorial(n-1) end
end

local function factorions(n)
   assert(type(n) == "number", "n should be a number!")
   local sum = 0
   local t = digits(n)
   for i=1, #t do
      sum = sum + factorial(t[i])
   end
   return sum == n
end

if #arg ~= 1 or tonumber(arg[1]) == nil then
   io.stderr:write("No args provided or arg is not numeric!\n")
   os.exit(1)
end

print(factorions(tonumber(arg[1])))
