def is_abundant(n):
  sum = 0
  for i in range(2,int(n/2 + 1)):
    if n % i == 0:
      sum += i
      if sum > n:
        return True
  return False

n = 1
count = 0
while count < 20:
  if is_abundant(n):
    print(n, end=' ')
    count += 1
  n += 2
