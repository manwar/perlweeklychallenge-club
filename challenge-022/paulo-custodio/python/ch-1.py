#!/usr/bin/python3

# Challenge 022
#
# Task #1
# Write a script to print first 10 Sexy Prime Pairs. Sexy primes are prime
# numbers that differ from each other by 6. For example, the numbers 5 and 11
# are both sexy primes, because 11 - 5 = 6. The term "sexy prime" is a pun
# stemming from the Latin word for six: sex. For more information, please
# checkout wiki page.

import sys
from primePy import primes

def next_prime(n):
    if n <= 1:
        return 2
    else:
        n += 1
        while not primes.check(n):
            n += 1
        return n

def sexy_primes_iter():
    a = 1
    while True:
        a = next_prime(a)
        b = a
        while b < a+6:
            b = next_prime(b)
        if b == a+6:
            yield (a, b)

count = 0
for a, b in sexy_primes_iter():
    print(f"({a}, {b})")
    count += 1
    if count >= 10:
        break
