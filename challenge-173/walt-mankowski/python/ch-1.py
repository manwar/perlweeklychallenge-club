#!/usr/bin/env python
import sys

def is_esthetic(n):
    d = [int(c) for c in str(n)]
    for i in range(1, len(d)):
        if abs(d[i-1]-d[i]) != 1:
            return False
    return True

n = int(sys.argv[1])
print(f'{n} {"is" if is_esthetic(n) else "is not"} an esthetic number')


