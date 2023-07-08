#!/usr/bin/env python
# -*- coding: utf-8 -*-

from fractions import Fraction


def find_ancestors(fraction):
    num, denom = map(int, fraction.split("/"))
    parent = Fraction(num, denom - num) if denom > num else Fraction(num - denom, denom)
    grandparent = (
        Fraction(parent.numerator, parent.denominator - parent.numerator)
        if parent.denominator > parent.numerator
        else Fraction(parent.numerator - parent.denominator, parent.denominator)
    )
    return str(parent), str(grandparent)


print(find_ancestors("3/5"))  # Output: ('3/2', '1/2')
print(find_ancestors("4/3"))  # Output: ('1/3', '1/2')
