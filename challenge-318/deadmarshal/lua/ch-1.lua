#!/usr/bin/env lua

local function group_position(str)
  assert(type(str) == 'string',
	 'str must be a string!')
  local groups,i,j = {},1
  while i <= #str do
    j = i
    while j <= #str and str:sub(j,j) == str:sub(i,i) do j = j + 1 end
    if j - i >= 3 then groups[#groups+1] = str:sub(i,j-1) end
    i = j
  end
  return groups
end

print(table.unpack(group_position"abccccd"))
print(table.unpack(group_position"aaabcddddeefff"))
print(table.unpack(group_position"abcdd"))

