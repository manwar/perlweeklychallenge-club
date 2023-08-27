#!/usr/bin/env python
# -*- coding: utf-8 -*-


def fizz_buzz():
    output = []
    for i in range(1, 21):
        line = ""
        if i % 3 == 0:
            line = "fizz"
        if i % 5 == 0:
            line += "buzz"
        if not line:
            line = i
        output.append(line)
    return output


# Simple test to verify the functionality
assert fizz_buzz() == [
    1,
    2,
    "fizz",
    4,
    "buzz",
    "fizz",
    7,
    8,
    "fizz",
    "buzz",
    11,
    "fizz",
    13,
    14,
    "fizzbuzz",
    16,
    17,
    "fizz",
    19,
    "buzz",
]
