local function reverse_num(n)
   assert(type(n) == 'number', 'n must be numeric!')
   local num = 0
   while n ~= 0 do
      num = (num * 10) + n % 10
      n = n // 10
   end
   return num
end

local function split_num(n)
   assert(type(n) == 'number', 'n must be numeric!')
   local t = {}
   while n ~= 0 do
      t[#t+1] = n % 10
      n = n // 10
   end
   return t
end

local function all(t, f)
   assert(type(t) == 'table' and
	  type(f) == 'function',
	  't and f must be a table and function respectively!')
   for i=1, #t do
      if not f(t[i]) then return false end
   end
   return true
end

local function is_reversible_number(n)
   assert(type(n) == 'number', 'n must be numeric!')
   local sum = n + reverse_num(n)
   if all(split_num(sum),
	  function(n) if n % 2 == 0 then return false end return true
	 end)
   then
      return true
   end
   return false
end

local i = 1
while i < 100 do
   if is_reversible_number(i) then io.write(i, ' ') end
   i = i + 1
end
