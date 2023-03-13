#!/usr/bin/env python
# -*- coding: utf-8 -*-


def is_prime(num: int) -> bool:
    if num < 2:
        return False
    for i in range(2, int(num**0.5) + 1):
        if num % i == 0:
            return False
    return True


def get_next_prime(num: int) -> int:
    num += 1
    while not is_prime(num):
        num += 1
    return num


perfect_numbers = []
p = 2
num = 2 ** (p - 1) * (2**p - 1)

while len(perfect_numbers) < 5:
    perfect_numbers.append(num)
    p = get_next_prime(p)
    num = 2 ** (p - 1) * (2**p - 1)

print("The first five perfect numbers are:", perfect_numbers)
