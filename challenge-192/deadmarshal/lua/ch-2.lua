local function table_sum(t)
  local sum = 0
  for i=1, #t do sum = sum + t[i] end
  return sum
end

local function equal_distribution(t)
  assert(type(t) == 'table', 't must be a table!')
  local sum = table_sum(t)
  local avg,moves,sum_part = sum // #t,0,0 
  if sum % #t == 0 then
    for i=1, #t do
      sum_part = sum_part + t[i]
      moves = moves + math.abs(sum_part - (avg * (i)))
    end
    return moves
  else
    return -1
  end
end

print(equal_distribution({1,0,5}))
print(equal_distribution({0,2,0}))
print(equal_distribution({0,3,0}))

