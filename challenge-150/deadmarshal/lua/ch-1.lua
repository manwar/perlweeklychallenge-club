assert(#arg == 2, "provide 2 args!")

local function fibonacci_words(t)
  assert(type(t) == "table", "t must be a table!") 
  repeat
    t[#t+1] = t[#t-1] .. t[#t]
  until #t[#t] >= 51
  local chars = {}  
  for i=1, #t[#t] do
    local c = t[#t]:sub(i,i)
    chars[#chars+1] = c
  end
  return chars[51]
end

print(fibonacci_words({arg[1], arg[2]}))

