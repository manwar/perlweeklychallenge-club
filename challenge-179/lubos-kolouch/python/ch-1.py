#!/usr/bin/env python
# -*- coding: utf-8 -*-

units = [
    "",
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
]
tens = [
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
]
teens = [
    "tenth",
    "eleventh",
    "twelfth",
    "thirteenth",
    "fourteenth",
    "fifteenth",
    "sixteenth",
    "seventeenth",
    "eighteenth",
    "nineteenth",
]


def ordinal(n: int) -> str:
    if n == 10:
        return "tenth"
    elif 10 < n < 20:
        return teens[n - 10]
    elif n < 10:
        return units[n]
    else:
        return tens[n // 10] + ("-" + units[n % 10] if n % 10 else "ieth")


print(ordinal(62))
