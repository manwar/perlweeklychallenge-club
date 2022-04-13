if #arg == 0 then
   io.stderr:write('No args provided!')
   os.exit(1)
end

if tonumber(arg[1]) > 9 then
   io.stderr:write('Number must be less than 10!')
   os.exit(1)
end

function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
end

function four_is_magic(n)
   assert(type(n) == "number", "n must be a number!")
   local t = {'one', 'two', 'three', 'four', 'five', 'six', 'seven',
	      'eight', 'nine'}
   local tbl, len = {}, #t[n]
   repeat
    tbl[#tbl+1] = t[n] .. ' is ' .. t[len]
    n = len
    len = #t[n]
   until n == 4
   tbl[#tbl+1] = 'four is magic.'
   return first_to_upper(table.concat(tbl, ', '))
end

print(four_is_magic(tonumber(arg[1])))
