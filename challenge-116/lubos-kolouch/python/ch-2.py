#!/usr/bin/env python
# -*- coding: utf-8 -*-

def sum_of_squares(n):
    sum = 0
    while n:
        digit = n % 10
        sum += digit * digit
        n = n // 10

    sqrt = int(sqrt(sum))
    if sqrt * sqrt == sum:
        return 1
    else:
        return 0


print(sum_of_squares(34))  # Prints 1
print(sum_of_squares(50))  # Prints 1
print(sum_of_squares(52))  # Prints 0
