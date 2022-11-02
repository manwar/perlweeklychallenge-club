local function greater_character(t,target)
  assert(type(t) == 'table' and type(target) == 'string',
	 't and target must be a table and a string respectively!')
  table.sort(t)
  for i=1, #t do
    if t[i] > target then return t[i] end
  end
  return target
end

print(greater_character({'e','m','u','g'}, 'b'))
print(greater_character({'d','c','e','f'}, 'a'))
print(greater_character({'j','a','r'}, 'o'))
print(greater_character({'d','c','a','f'}, 'a'))
print(greater_character({'t','g','a','l'}, 'v'))
