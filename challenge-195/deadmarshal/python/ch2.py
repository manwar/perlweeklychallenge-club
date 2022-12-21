from functools import reduce

def most_frequent_even(arr):
  if all(map(lambda n: n % 2 != 0, arr)): return -1
  d = {}
  for i in arr:
    if i % 2 == 0: d[i] = d.get(i, 0) + 1
  if len(d.values()) == len(set(d.values())): return min(d)
  return reduce(lambda a,b:a if d[a] > d[b] else b, d.keys())

print(most_frequent_even([1,1,2,6,2]))
print(most_frequent_even([1,3,5,7]))
print(most_frequent_even([6,4,4,6,1]))

