test = [2, 9, 3, 5]
sorted = test.sort
gaps = (1.upto(sorted.length()-1)).map { |i| sorted[i] - sorted[i - 1] }
print "Max gap is: ", gaps.max
