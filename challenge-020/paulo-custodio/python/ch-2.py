#!/usr/bin/python3

# Challenge 020
#
# Task #2
# Write a script to print the smallest pair of Amicable Numbers. For more
# information, please checkout wikipedia page.

import math

def divisors(n):
    div_low = []
    div_high = []
    for i in range(1, int(math.sqrt(n)+1)):
        if n%i==0:
            div_low.append(i)
            if n/i!=i:
                div_high.insert(0, int(n/i))
    return [*div_low, *div_high]

def proper_divisors(n):
    return filter(lambda x:x!=n, divisors(n))

def smallest_amicable_pair():
    n = 1
    while True:
        n += 1
        sum1 = sum(proper_divisors(n))
        sum2 = sum(proper_divisors(sum1))
        if sum2==n and n<sum1:
            return n, sum1

a, b = smallest_amicable_pair()
print(f"({a},{b})")
