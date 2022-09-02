if #arg ~= 1 then
  io.stderr:write('No arg(s) provided!')
  os.exit(1)
end

local function first_unique_character(str)
  assert(type(str) == 'string', 'str must be a string!')
  local chars, hash = {}, {}
  str:gsub(".", function(c) table.insert(chars, c) end)
  setmetatable(hash, {__index = function(t, k) return 0 end})
  for i, v in ipairs(chars) do
    hash[v] = hash[v] + 1
  end
  for i=1, #chars do
    if hash[chars[i]] == 1 then
      return string.format("%d as '%s' is the first unique character",
		    i-1, chars[i])
    end
  end
end

print(first_unique_character(arg[1]))
