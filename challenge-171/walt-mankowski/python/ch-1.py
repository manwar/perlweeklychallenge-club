#!/usr/bin/env python

def odd_divisors(n):
    od = [i for i in range(1,n//2+1,2) if n % i == 0]
    return od

abundant = []
n = 1
while len(abundant) < 20:
    od = odd_divisors(n)
    if sum(od) > n:
        abundant.append(n)
        sum_str = ' + '.join([str(i) for i in od])
        print(f"{len(abundant):2d}: {sum_str} = {sum(od)} > {n}")
    n += 2
print(abundant)


        
