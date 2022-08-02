if #arg ~= 1 then
   io.stderr:write('No arg(s) provided!')
   os.exit(1)
end

if not arg[1]:match("%d+") or tonumber(arg[1]) <= 1752 then
   io.stderr:write('Arg must be numeric or is <= than 1752')
   os.exit(1)
end

local function is_leap_year(year)
   assert(type(year) == 'number', 'year must be numeric!')
   if year % 100 == 0 then return year % 400 == 0 end
   return year % 4 == 0
end

local function last_sunday(year)
   assert(type(year) == 'number', 'year must be numeric!')
   local days = {31,28,31,30,31,30,31,31,30,31,30,31}
   local week
   if is_leap_year(year) then days[2] = 29 end
   week = year * 365 + 97 * (year-1) + 4;
   for month=1, #days do
      week = (week + days[month]) % 7
      print(string.format('%d-%02d-%d',
			  year,
			  month,
			  days[month] - week));
   end
end

last_sunday(tonumber(arg[1]))
