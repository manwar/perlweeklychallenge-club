#!/usr/bin/env python

from fractions import Fraction
import sys


def get_parent(f):
    # 1/1 and -1/1 are orphened fractions.
    if f is None or abs(f) == 1:
        return None

    # Deal with postive fractions for now
    new_n = abs(f.numerator)
    new_d = f.denominator

    if new_n > new_d:  # f > 1
        new_n = new_n - new_d
    else:
        new_d = new_d - new_n

    # Turn the fraction back to negative if needed
    if f < 0:
        new_n = 0 - new_n

    return Fraction(new_n, new_d)


def f(f):
    # Fraction's str method won't show the denominator when it is 1
    return f"'{f.numerator}/{f.denominator}'" if f is not None else 'None'


def main(member):
    fract = Fraction(member)
    parent = get_parent(fract)
    grandparent = get_parent(parent)

    print(f"parent = {f(parent)} and grandparent is {f(grandparent)}")


if __name__ == '__main__':
    main(sys.argv[1])
