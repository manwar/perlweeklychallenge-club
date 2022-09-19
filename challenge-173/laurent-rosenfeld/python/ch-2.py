s = [2];
for i in range(9):
  s.append(s[-1] * (s[-1] - 1) + 1)
for j in s:
  print(j)
