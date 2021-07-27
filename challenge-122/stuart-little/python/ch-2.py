#!/usr/bin/env python

# run <script> <score>

import sys

def comp(nr,bd):
    tab=[[[],],]
    for n in range(1,nr+1):
        item=[]
        for i in range(1,bd+1):
            if (len(tab) >= i):
                suppPrev = [[i] + ar for ar in tab[-i]]
                item.extend(suppPrev)                           
        if (len(tab) >= bd):
            tab=tab[1:]
        tab.append(item)    
    return tab[-1]

for cmp in comp(int(sys.argv[1]),3):
    print(cmp)
