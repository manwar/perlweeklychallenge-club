#!/usr/bin/env python

# run <script> <number>

import math
import sys

digSqSum=sum(map(lambda x: int(x) ** 2,list(sys.argv[1])))
print(int(digSqSum == int(math.sqrt(digSqSum)) ** 2))
