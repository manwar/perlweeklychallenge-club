def binary_prefix(arr):
  res = []
  x = 0
  for i in range(len(arr)):
    x = (x << 1 | arr[i]) % 5
    res.append(x == 0)
  return res

print(binary_prefix([0,1,1,0,0,1,0,1,1,1]))
print(binary_prefix([1,0,1,0,1,0]))
print(binary_prefix([0,0,1,0,1]))
print(binary_prefix([1,1,1,1,1]))
print(binary_prefix([1,0,1,1,0,1,0,0,1,1]))

