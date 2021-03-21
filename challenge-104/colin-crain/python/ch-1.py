#!/usr/bin/env python3
#
#
#       104-1-fusc-yuo-too.py
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


import functools

@functools.lru_cache(maxsize=128)

def fusc(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
               
    if n % 2:
        return fusc( (n-1)/2 ) + fusc( (n+1)/2 )
    
    return fusc(n/2)


for n in range (1,11):
    print( fusc(n) )
