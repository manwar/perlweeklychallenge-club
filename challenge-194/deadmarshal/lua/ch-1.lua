local function digital_clock(str)
  local one,two,three,four = str:match('(.)(.):(.)(.)')
  if one == '?' then
    if tonumber(two) < 4 then return 2 else return 1 end
  elseif two == '?' then
    if tonumber(one) < 2 then return 9 else return 3 end
  elseif three == '?' then
    return 5
  else return 9
  end
end

print(digital_clock('?5:00'))
print(digital_clock('?3:00'))
print(digital_clock('1?:00'))
print(digital_clock('2?:00'))
print(digital_clock('12:?5'))
print(digital_clock('12:5?'))

