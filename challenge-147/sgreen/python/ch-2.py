#!/usr/bin/env python

import math


def pentagon_number(n):
    return int(n * (3 * n - 1) / 2)


def is_pentagon_number(x):
    n = math.sqrt(24 * x + 1) + 1
    return int(n / 6) if n % 6 == 0 else None


def main():
    n1 = 2
    while True:
        p1 = pentagon_number(n1)
        for n2 in range(1, n1):
            p2 = pentagon_number(n2)

            s1 = is_pentagon_number(p1 + p2)
            s2 = is_pentagon_number(p1 - p2)

            if s1 is not None and s2 is not None:
                print(f'P({n1}) + P({n2}) = {p1} + {p2} = { p1 + p2 } = P({s1})')
                print(f'P({n1}) - P({n2}) = {p1} - {p2} = { p1 - p2 } = P({s2})')
                return
        n1 += 1


main()
