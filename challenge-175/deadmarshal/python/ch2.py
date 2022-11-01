from math import gcd

def phi(n):
  amount = 0        
  for k in range(1, n + 1):
    if gcd(n, k) == 1:
      amount += 1
  return amount 

def phi_iter(n):
  if n == 2: return phi(n)
  return phi(n) + phi_iter(phi(n))

i,count = 2,0
while count != 20:
  if i == phi_iter(i):
    print(i, end=' ')
    count += 1
  i += 1
  
