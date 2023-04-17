#!/usr/bin/env python
# -*- coding: utf-8 -*-

def is_colorful(number: int) -> bool:
    products = set()

    digits = [int(d) for d in str(number)]
    length = len(digits)

    for i in range(length):
        product = 1
        for j in range(i, length):
            product *= digits[j]
            if product in products:
                return False
            products.add(product)

    return True

if __name__ == "__main__":
    for num in range(100, 1000):
        if is_colorful(num):
            print(num)
