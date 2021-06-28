#!/usr/bin/env python

# run <script> <number>

import sys

print(int(f"{(int(sys.argv[1]) & 15):04b}" + f"{(int(sys.argv[1]) >> 4 & 15):04b}", base=2))
