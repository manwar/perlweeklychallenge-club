#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import Tuple
from sympy import isprime


def is_sexy_prime_pair(num: int) -> Tuple[int, bool]:
    """
    Check if the given number and the number 6 greater than it form a sexy prime pair.

    :param num: An integer
    :return: A tuple containing the number and a boolean indicating if it's part of a sexy prime pair
    """
    return (num, isprime(num) and isprime(num + 6))


def main() -> None:
    """
    Prints the first 10 sexy prime pairs.
    """
    count = 0
    num = 2

    while count < 10:
        sexy_prime = is_sexy_prime_pair(num)
        if sexy_prime[1]:
            print(f"({sexy_prime[0]}, {sexy_prime[0] + 6})")
            count += 1
        num += 1


if __name__ == "__main__":
    main()
