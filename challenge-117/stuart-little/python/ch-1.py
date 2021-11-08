#!/usr/bin/env python

# run <script> <path-to-file>

import re
import sys

with open(sys.argv[1], 'r') as f:
    lns = f.readlines()

print(int((len(lns)+2)*(len(lns)+1)/2) - sum([int(re.search(r"\d+", ln).group(0)) for ln in lns]))
