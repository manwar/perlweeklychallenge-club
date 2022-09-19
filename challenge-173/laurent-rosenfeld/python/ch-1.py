def is_esthetic(m):
  n = str(m)
  for i in range(1, len(n)):
    if abs(int(n[i]) - int(n[i - 1 ])) != 1:
      return False
  return True

for test in [5456, 120, 121, 23456, 2346, 7654567, 765467]:
  if is_esthetic(test):
    print("{:<9d} is esthetic".format(test))
  else:
    print("{:<9d} is not esthetic".format(test))
