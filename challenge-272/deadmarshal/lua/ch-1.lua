#!/usr/bin/env lua

local function defrag_ip_address(str)
  assert(type(str) == 'string','str must be a string!')
  return (str:gsub("%.","[.]"))
end

print(defrag_ip_address('1.1.1.1'))
print(defrag_ip_address('255.101.1.0'))

