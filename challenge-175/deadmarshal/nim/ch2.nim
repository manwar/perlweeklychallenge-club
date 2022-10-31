import std/math

proc phi(n:int):int =
  var amount = 0
  for k in 1..n:
    if gcd(n,k) == 1:
      amount += 1
  return amount
  
proc phiIter(n:int):int =
  if n == 2: return phi(n)
  return phi(n) + phiIter(phi(n))

var
  i = 2
  count = 0
  
while count != 20:
  if i == phiIter(i):
    stdout.write(i, ' ')
    count += 1
  i += 1
  
