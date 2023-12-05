#! /usr/bin/python3

import random

candidates = list(range(1, 50))
random.shuffle(candidates)
candidates = candidates[0:6]
candidates.sort()
print(candidates)
