#!/usr/bin/env python

# run <script> <space-separated numbers>

import sys

print([sum([float(x) for x in sys.argv[1:i+1]])/i for i in range(1,len(sys.argv))])
