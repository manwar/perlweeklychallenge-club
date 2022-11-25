local function binary_flip(n)
  assert(type(n) == 'number', 'n must be a number!')
  return (~n) & (2 ^ (math.log(n) // math.log(2))-1)
end

print(binary_flip(5))
print(binary_flip(4))
print(binary_flip(6))

