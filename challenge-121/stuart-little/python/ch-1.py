#!/usr/bin/env python

# run <script> <bit position>

import sys

print(int(sys.argv[1]) ^ 2**(int(sys.argv[2])-1))
