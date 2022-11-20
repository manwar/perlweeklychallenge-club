from itertools import permutations

def is_cute(arr):
  for i in range(1,len(arr)+1):
    if i % arr[i-1] != 0 and arr[i-1] % i != 0: return False
  return True

def cute_list(n):
  arr = list(range(1,n+1))
  count = 0
  for perm in permutations(arr):
    if is_cute(perm): count += 1
  return count

print(cute_list(2))
