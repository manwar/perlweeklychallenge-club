#!/usr/bin/env python

# run <script> <space-separated numbers>

import sys

srt = sorted(map(lambda x: int(x), sys.argv[1:]))
diffs = [y-x for (x,y) in zip(srt,srt[1:])]

print(max(diffs) if len(diffs)>0 else 0)
