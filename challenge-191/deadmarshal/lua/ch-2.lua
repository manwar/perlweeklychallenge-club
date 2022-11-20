local function is_cute(t)
  assert(type(t) == 'table', 't must be a table!')
  for i=1, #t do
    if i % t[i] ~= 0 and t[i] % i ~= 0 then return false end
  end
  return true
end

local function permute(t, i, sz, t2)
  assert(type(t) == 'table' and
	 type(i) == 'number' and
	 type(sz) == 'number' and
	 type(t2) == 'table', 'params assertions failed!')
  if sz == i then
    if is_cute(t) then t2.count = t2.count + 1 return end
  end
  for j=i, sz do
    t[i], t[j] = t[j], t[i]
    permute(t,i+1,sz,t2)
    t[i], t[j] = t[j], t[i]
  end
  return
end

local t,t2 = {1,2},{count = 0}
permute(t, 1, 2, t2)
print(string.format("%d",t2.count))

