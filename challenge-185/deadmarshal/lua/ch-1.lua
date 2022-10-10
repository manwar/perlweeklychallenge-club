local function mac_address(str)
  assert(type(str) == 'string', 'str must be a string!')
  local sansdot = str:gsub("%.", "")
  local ret,i = {},1
  while i < #sansdot do
    ret[#ret+1] = sansdot:sub(i, i+1)
    i = i + 2
  end
  return table.concat(ret, ":")
end

print(mac_address("1ac2.34f0.b1c2"))
print(mac_address("abc1.20f1.345a"))

