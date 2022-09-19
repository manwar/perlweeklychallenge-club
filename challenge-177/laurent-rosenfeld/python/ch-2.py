import math
from re import search
from itertools import chain

def is_prime(n):
  if n == 2:
    return True
  if n == 0 or n == 1 or n % 2 == 0:
    return False
  p = 3
  sqrt_n = math.sqrt(n)
  while (p <= sqrt_n):
    if ((n % p) == 0):
      return False
    p += 2
  return True

def is_cyclops (num):
  s = str(num)
  size = len(s)
  if size % 2 == 0:
    return False
  mid = int((size - 1) / 2)
  if s[mid] != '0':
    return False
  if search(r"0", s[0:mid-1]) or search(r"0", s[mid+1:size-1]):
    return False
  return True

count = 0
myrange = chain(range(100, 999), range(10000, 99999), range(1000000, 9999999))
for i in myrange:
  if str(i) != str(i)[::-1]:
    continue
  if not is_cyclops(i):
    continue
  if is_prime(i):
    print(i, end=' ')
    count += 1
    if count >= 20:
      break

print("")
