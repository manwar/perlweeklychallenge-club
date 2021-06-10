#!/usr/bin/env python

# run <script> <path-to-dict-file, one word per line>

import sys

def isSorted(wrd):
    return wrd.isalpha() and all([wrd.lower()[i] <= wrd.lower()[i+1] for i in range(0,len(wrd)-1)])

def longestWith(lst,pred):
    lngth=0
    res=[]
    for wrd in lst:
        if (not pred(wrd)):
            continue
        l=len(wrd)        
        if l > lngth:
            lngth = l
            res=[wrd]
            continue
        if l == lngth:
            res.append(wrd)
    return res
    
with open(sys.argv[1]) as fh:
    wrds=filter(lambda ln: len(ln) > 0, map(lambda ln: ln.strip(), fh.readlines()))

for wrd in longestWith(wrds,isSorted):
    print(wrd)
