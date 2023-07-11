#!/usr/bin/env python
# -*- coding: utf-8 -*-


def dot_product(a, b):
    return sum(x * y for x, y in zip(a, b))


a = [1, 2, 3]
b = [4, 5, 6]
print(dot_product(a, b))  # Output: 32
