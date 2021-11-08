#!/usr/bin/env python

# run <script> <space-separated strings>

import sys

def canChain(words,start,end):
    if len(words) == 0:
        return 0
    if len(words) == 1:
        return int(words[0][0] == start and words[0][-1] == end)
    startIdxs = filter(lambda ix: words[ix][0] == start, range(len(words)))
    return int(any(map(lambda ix: canChain([words[x] for x in range(len(words)) if x != ix], words[ix][-1], end), startIdxs)))

print(0 if len(sys.argv) < 3 else canChain(sys.argv[2:], sys.argv[1][-1], sys.argv[1][0]))
