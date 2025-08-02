
import math

## nInput = 27  ## Example 1
## nInput = 0  ## Example 2
nInput = 6  ## Example 3

dCubicRoot = nInput ** (1. / 3.)

if dCubicRoot - int(dCubicRoot) > 0:
    print (False)
else:
    print (True)
