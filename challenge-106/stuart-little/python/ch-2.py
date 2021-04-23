#!/usr/bin/env python

# run <script> <numerator> <denominator>

import sys

def maxExp(p,n):
    return 0 if (n % p) else (1+maxExp(p, n//p))

def ordExp(n,p):
    (order,base)=(1,n % p)
    while (base-1 % p):
        order += 1
        base = (base * n) % p
    return order

def when10copr(num,den):
    intg = num//den
    digs = ordExp(10,den)
    fract = ((num % den) * (10**digs-1)) // den
    return intg, '0' * (digs - len(str(fract))) + str(fract)

def fractPart(num,den):
    exp2 = maxExp(2,den)
    exp5 = maxExp(5,den);
    newNum = (5**(exp2-exp5) * num) if (exp2 >= exp5) else (2**(exp5-exp2) * num)
    copr = when10copr(newNum, den // (2**exp2 * 5**exp5))
    nonRep = ('0' * (max(exp2,exp5) - len(str(copr[0]))) + str(copr[0])) if (copr[0] or max(exp2,exp5)) else ""
    rep = f"({copr[1]})" if (copr[1] != "0") else ""
    return nonRep + rep

(num,den) = list(map(lambda x: int(x), sys.argv[1:3]))
print(f"{num//den}.{fractPart(num % den,den)}")
