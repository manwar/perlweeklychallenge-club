def sparkline(test):
  bars = [chr(bar) for bar in range(9601, 9608+1)]
  minim = min(test)
  maxim = max(test)
  scale = maxim - minim
  length = len(bars)
  line = ""
  for item in test:
    line += bars[min(int((item-minim) / scale * length), length - 1)]
  return line

tests = [ [2, 4, 6, 8, 10, 12, 10, 8, 6, 4, 2], \
  [0, 1, 19, 20], [0, 999, 4000, 4999, 7000, 7999] ]

for test in tests:
  print(test)
  print(sparkline(test), "\n")
