proc isPrime(n:int):bool =
  var i = 5
  if n == 2 or n == 3: return true
  if n <= 1 or n mod 2 == 0 or n mod 3 == 0: return false
  while i * i <= n:
    if n mod i == 0 or n mod (i+2) == 0: return false
    i += 6
  return true

proc primeCount(n:int):int =
  for i in 1..<n:
    if isPrime(i): result += 1
    
echo primeCount(10)
echo primeCount(15)
echo primeCount(1)
echo primeCount(25)

