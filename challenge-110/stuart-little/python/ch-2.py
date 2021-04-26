#!/usr/bin/env python

# run <script> <path-to-file or nothing>
# defaults to challenge sample if no file is entered

import sys

if (len(sys.argv)>1):
    with open(sys.argv[1]) as f:
        data=f.read()
else:
    data="""name,age,sex
Mohammad,45,m
Joe,20,m
Julie,35,f
Cristina,10,f
"""

transpLines = list(map(lambda x: ','.join(x), list(zip(*list(map(lambda x: x.split(','),data.splitlines()))))))
for ln in transpLines:
    print(ln)
