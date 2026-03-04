#!/usr/bin/env python3

# Challenge 286

import sys
from random import shuffle

n = -1
if len(sys.argv) == 2:
    n = int(sys.argv[1])

f = open(sys.argv[0], "r")
text = f.read()
words = text.split()

if n == -1:
    shuffle(words)
    print(words[0])
else:
    print(words[n])
