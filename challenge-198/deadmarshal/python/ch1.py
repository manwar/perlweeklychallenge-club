def max_gap(arr):
  if len(arr) < 2: return 0
  count,temp,mx = 0,0,0
  arr.sort()
  for i in range(0,len(arr),2):
    temp = abs(arr[i] - arr[i+1])
    if temp > mx: mx = temp
  for i in range(0,len(arr)-1):
    if abs(arr[i] - arr[i+1]) == mx: count += 1
  return count
    
print(max_gap([2,5,8,1]))
print(max_gap([3]))

