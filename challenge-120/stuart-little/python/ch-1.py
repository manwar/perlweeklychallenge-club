#!/usr/bin/env python

# run <script> <number>

import sys

print(int("".join([f"{(int(sys.argv[1]) & 255):08b}"[2*x:2*x+2][::-1] for x in range(4)]) , base=2))
