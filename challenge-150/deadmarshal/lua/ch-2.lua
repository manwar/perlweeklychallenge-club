local function prime_factors(n)
  assert(type(n) == "number", "n must be a number!")
  local t, c = {}, 2
  while n > 1 do
    if n % c == 0 then
      t[#t+1] = c
      n = n // c
    else c = c + 1
    end
  end
  return t
end

local function uniq(t)
  assert(type(t) == "table", "t must be a table!")
  table.sort(t)
  for i=1, #t do
    for j=i+1, #t do
      if t[i] == t[j] then return false end
    end
  end
  return true
end

local function square_free_integers()
  local t, i = {}, 1
  repeat
    if uniq(prime_factors(i)) then
      t[#t+1] = i
    end
    i = i + 1 
  until i >= 500
  return t
end

local sfi = square_free_integers()
for i=1, #sfi do io.write(sfi[i], ' ') end

