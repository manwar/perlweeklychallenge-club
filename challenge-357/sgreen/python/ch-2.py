#!/usr/bin/env python3

from fractions import Fraction
import sys


def unique_fraction_generator(number: int) -> list[str]:
    """
    Return all fractions that meet a specific criteria, sorted numerically.

    Params:
        number(int): The maximum number for the numerator and denominator.

    Returns:
        list[str] - A list of all fractions (as strings) sorted numerically.
    """
    fractions = sorted(set(
        Fraction(n, d)
        for d in range(1, number + 1)
        for n in range(1, number+1)
    ))

    return [f"{frac.numerator}/{frac.denominator}" for frac in fractions]


def main():
    result = unique_fraction_generator(int(sys.argv[1]))
    print(', '.join(result))


if __name__ == "__main__":
    main()
