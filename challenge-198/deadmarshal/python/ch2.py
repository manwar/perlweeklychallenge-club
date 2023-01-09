def is_prime(n):
  i = 5
  if n == 2 or n == 3: return True
  if n <= 1 or n % 2 == 0 or n % 3 == 0: return False
  while i * i <= n:
    if n % i == 0 or n % (i+2) == 0: return false
    i += 6
  return True

def prime_count(n):
  count = 0
  for i in range(1,n):
    if is_prime(i): count += 1
  return count

print(prime_count(10))
print(prime_count(15))
print(prime_count(1))
print(prime_count(25))

