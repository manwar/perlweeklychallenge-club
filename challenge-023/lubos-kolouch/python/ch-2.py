#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
from typing import List


def prime_decomposition(n: int) -> List[int]:
    """
    Compute the prime factors of a number.

    Args:
        n: An integer greater than or equal to 2.

    Returns:
        A list of prime factors of the input number.

    Raises:
        ValueError: If the input number is less than 2.
    """
    if n < 2:
        raise ValueError("Number should be greater than or equal to 2")

    factors = []
    d = 2

    # Divide the number by prime factors
    while n > 1:
        while n % d == 0:
            factors.append(d)
            n //= d
        d += 1
        if d * d > n and n > 1:
            factors.append(n)
            break

    return factors


# Test cases
def test_prime_decomposition():
    assert prime_decomposition(228) == [2, 2, 3, 19]
    assert prime_decomposition(131) == [131]
    assert prime_decomposition(101) == [101]
    try:
        prime_decomposition(1)
    except ValueError:
        pass
    else:
        assert False, "Expected ValueError for input 1"


if __name__ == '__main__':
    # Parse command line argument
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <number>")
        sys.exit(1)
    n = int(sys.argv[1])

    # Compute the prime decomposition
    factors = prime_decomposition(n)

    # Print the prime factors
    print(", ".join(str(f) for f in factors))

    # Run tests
    test_prime_decomposition()
