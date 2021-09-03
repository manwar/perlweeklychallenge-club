#!/usr/bin/env python

# run <script> <left1 right1 left2 right2 ...>

from itertools import combinations
import sys

print(list(set([pr[1] for pr in filter(lambda pr: (pr[1][1]-pr[0][0])*(pr[1][0]-pr[0][1]) <= 0, combinations([(int(sys.argv[2*i+1]), int(sys.argv[2*i+2])) for i in range(len(sys.argv[1:])//2)], 2))])))

