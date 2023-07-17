#!/usr/bin/env python
# -*- coding: utf-8 -*-

limit = 20
num = 1
abundant = []

while len(abundant) < limit:
    sum = 0
    for i in range(1, num):
        if num % i == 0:
            sum += i

    if sum > num and num % 2 != 0:
        abundant.append(num)

    num += 1

print(abundant)
