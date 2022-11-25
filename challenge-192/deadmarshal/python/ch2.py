def equal_distribution(arr):
  summ,avg,moves,sumpart = 0,0,0,0
  summ = sum(arr)
  if summ % len(arr) == 0:
    avg = summ // len(arr)
    for i in range(len(arr)):
      sumpart += arr[i]
      moves += abs(sumpart - (avg * (i+1)))
    return moves
  return -1

print(equal_distribution([1,0,5]))
print(equal_distribution([0,2,0]))
print(equal_distribution([0,3,0]))

