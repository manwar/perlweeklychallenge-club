if #arg ~= 1 then
   io.stderr:write('No args provided!')
   os.exit(1)
end

local function is_esthetic_number(n)
   assert(type(n) == 'number', 'n must be a number!')
   local function uabs(a, b)
      if a < b then return b - a else return a - b end
   end
   if n == 0 then return false end
   local i = n % 10
   n = n // 10
   while n > 0 do
      local j = n % 10
      if uabs(i, j) ~= 1 then return false end
      n = n // 10
      i = j
   end
   return true
end

print(is_esthetic_number(tonumber(arg[1])))
