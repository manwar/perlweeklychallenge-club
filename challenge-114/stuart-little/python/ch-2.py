#!/usr/bin/env python

# run <script> <number>

import re
import sys

binNr=f"0{int(sys.argv[1]):b}"
print(f"Initial number in base two: {binNr}")

nxt = re.sub(r"01(1*)$", r"10\1", binNr) if (int(sys.argv[1]) % 2) else re.sub(r"01(1*)(0*)$", r"10\2\1", binNr)
print(f"Next number in base two: {nxt}")

print(f"Next number in base two: {int(nxt, base=2)}")
