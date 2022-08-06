def check_multiples(n):
  input = [int(c) for c in str(n)]
  input.sort()
  for i in range(2, 7):
    test = [int(c) for c in str(n * i)]
    test.sort()
    if input != test:
      return False
  return True


i = 2
while True:
  if check_multiples(i):
    print(i)
    break
  i += 1
