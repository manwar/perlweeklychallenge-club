for test in [5, 2, 9, 1, 7, 6], [4, 2, 3, 1, 5, 0]:
  max_i = 0
  max_n = test[0]
  for i in range(1, len(test)):
    if test[i] > max_n:
      max_n = test[i]
      max_i = i
  print("Max index for ", test, ": ", max_i, " => ", max_n)
