#!/usr/bin/env python

# run <script> <number>

import re
import sys

def nxt(st):
    mtch=re.match(r"(.*)([^3])(3*)$",st)
    if mtch and mtch.group(2):
        return mtch.group(1) + str(int(mtch.group(2))+1) + ('12' * len(mtch.group(3)))[0:len(mtch.group(3))]
    return ('12' * len(st))[0:len(st)+1]

out = '0'
for _ in range(int(sys.argv[1])):
    out = nxt(out)
print(out)
