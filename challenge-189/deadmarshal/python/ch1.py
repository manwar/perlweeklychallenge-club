def greater_character(arr, target):
  arr.sort()
  for i in range(0,len(arr)):
    if arr[i] > target: return arr[i]
  return target

print(greater_character(['e','m','u','g'], 'b'))
print(greater_character(['d','c','e','f'], 'a'))
print(greater_character(['j','a','r'], 'o'))
print(greater_character(['d', 'c', 'a', 'f'], 'a'))
print(greater_character(['t', 'g', 'a', 'l'], 'v'))
