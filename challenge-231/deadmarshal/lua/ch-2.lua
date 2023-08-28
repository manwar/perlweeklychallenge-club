#!/usr/bin/env lua

local function senior_citizens(t)
  local count = 0
  for i=1,#t do
    if tonumber(t[i]:sub(-4,-3)) >= 60 then count = count + 1 end
  end
  return count
end

print(senior_citizens{"7868190130M7522",
		      "5303914400F9211",
		      "9273338290F4010"})
print(senior_citizens{"1313579440F2036",
		      "2921522980M5644"})

