import math

var cache: array[0..10000, int]

proc is_perfect_totient (n: int): bool =
  var tot = 0
  for i in 1..n-1:
    if (gcd(n, i) == 1):
      tot += 1
  let sum = tot + cache[tot]
  cache[n] = sum
  return sum == n

var i = 1
var count = 0
while count < 20:
  if is_perfect_totient(i):
    stdout.write i, " "
    count += 1
  i += 1
echo ""
