#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math


def chowla(n):
    sum = 0
    for i in range(2, math.isqrt(n) + 1):
        if n % i == 0:
            sum += i
            if i != n//i:
                sum += n//i
    return sum


for n in range(1, 21):
    print(chowla(n))
