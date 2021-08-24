#!/usr/bin/env python

# run <script> <space-separated set entries, with a '-' separating the two sets>

import sys

flag=0
s1,s2=[],[]
for it in sys.argv[1:]:
    if it=='-':
        flag=1
        continue
    (s1,s2)[flag].append(it)
print(1-min(1,len(set(s1).intersection(set(s2)))))
