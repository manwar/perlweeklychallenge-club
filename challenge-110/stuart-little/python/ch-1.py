#!/usr/bin/env python

# run <script> <path-to-file or nothing>
# defaults to challenge sample if no file is entered

import re
import sys

if (len(sys.argv)>1):
    with open(sys.argv[1]) as f:
        data=f.read()
else:
    data="""
0044 1148820341
 +44 1148820341
  44-11-4882-0341
(44) 1148820341
  00 1148820341
"""
rgx=re.compile(r'((?:\+\d{2}|\(\d{2}\)|\d{4})\s+\d{10})')
nrs=re.findall(rgx,data)
for nr in nrs:
    print(nr)
