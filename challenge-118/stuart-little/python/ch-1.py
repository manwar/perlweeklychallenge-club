#!/usr/bin/env python

# run <script> <number>

import sys

bn=bin(int(sys.argv[1]))[2:]
print(0+(bn == bn[::-1]))
