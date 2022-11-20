def twice_largest(arr):
  arr.sort(reverse=True)
  if arr[0] >= (2 * arr[1]): return 1
  return -1

print(f"{twice_largest([1,2,3,4]):>2}")
print(f"{twice_largest([1,2,0,5]):>2}")
print(f"{twice_largest([2,6,3,1]):>2}")
print(f"{twice_largest([4,5,2,3]):>2}") 
      
