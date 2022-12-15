def special_integers(n):
  count = 0
  for i in range(1,n+1):
    digits = [int(x) for x in str(i)]
    if len(digits) == len(set(digits)): count += 1
  return count

print(special_integers(15))
print(special_integers(35))

