local function divisible_pairs(t,k)
  assert(type(t) == 'table' and type(k) == 'number',
	 't,k must be a table and a number respectively!')
  local count = 0
  for i=1, #t do
    for j=i+1, #t do
      if (t[i] + t[j]) % k == 0 then count = count + 1 end
    end
  end
  return count
end

print(divisible_pairs({4,5,1,6}, 2))
print(divisible_pairs({1,2,3,4}, 2))
print(divisible_pairs({1,3,4,5}, 3))
print(divisible_pairs({5,1,2,3}, 4))
print(divisible_pairs({7,2,4,5}, 4))
