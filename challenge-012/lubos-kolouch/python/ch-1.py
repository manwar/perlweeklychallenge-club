#!/usr/bin/env python
# -*- coding: utf-8 -*-

from math import sqrt


def is_prime(n):
    if n < 2:
        return False
    for i in range(2, int(sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True


p = 2
euclid_number = 3

while is_prime(euclid_number):
    p += 1
    while not is_prime(p):
        p += 1
    euclid_number = (2 ** (p - 1)) * ((2**p) - 1)

print(f"The smallest Euclid number that is not prime is: {euclid_number}")
