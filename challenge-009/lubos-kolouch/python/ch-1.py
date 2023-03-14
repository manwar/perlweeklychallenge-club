#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math

num = 1

while True:
    square = num * num
    digits = set(str(square))

    if len(digits) >= 5:
        print(f"The first square number with at least 5 distinct digits is: {square}")
        break

    num += 1
