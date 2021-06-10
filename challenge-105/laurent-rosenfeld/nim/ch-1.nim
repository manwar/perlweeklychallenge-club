import math

var input = 248832.0
for i in 1..8:
  var root = pow(input, 1.0 / float(i))
  echo i, "   ", root
