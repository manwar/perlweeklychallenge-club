local function mask_code(t)
  assert(type(t) == 'table', 't must be a table!')
  local count = 0
  for i=1, #t do
    local chars = {}
    t[i]:gsub(".", function(c) table.insert(chars, c) end)
    for j=1, #chars do
      if chars[j]:match("[a-z0-9]") then
	chars[j] = 'x'
	count = count + 1
      end
      t[i] = table.concat(chars)
      if count == 4 then break end
    end
    count = 0
  end
end

local list = {'ab-cde-123', '123.abc.420', '3abc-0010.xy'};
local list2 = {'1234567.a', 'a-1234-bc', 'a.b.c.d.e.f'};
mask_code(list)
mask_code(list2)
print(table.concat(list, " "))
print(table.concat(list2, " "))

