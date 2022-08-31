for test in [3, [1,4,2,3,5]], [4, [9,0,6,2,3,8,5]]:
  i = test[0]
  nums = test[1]
  print(i, nums, " => ", list(filter(lambda n: n>i, nums)))
