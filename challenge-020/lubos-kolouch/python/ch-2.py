#!/usr/bin/env python3
"""
Challenge 020 - Task 2: Smallest Amicable Numbers

Write a script to print the smallest pair of Amicable Numbers.

Amicable numbers are two different numbers where each number is the sum of
the proper divisors of the other. The smallest pair is (220, 284).

For example:
- Proper divisors of 220 are: 1, 2, 4, 5, 10, 11, 20, 22, 44, 55, 110
- Sum of these = 284
- Proper divisors of 284 are: 1, 2, 4, 71, 142
- Sum of these = 220

Thus (220, 284) is an amicable pair.
"""

import math


def get_proper_divisors(n: int) -> list[int]:
    """
    Get all proper divisors of a number (excluding the number itself).

    Args:
        n: The number to find proper divisors for

    Returns:
        List of proper divisors
    """
    if n <= 1:
        return []

    divisors = [1]  # 1 is always a proper divisor

    # Check for divisors from 2 to sqrt(n)
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            divisors.append(i)
            if i != n // i:  # Avoid duplicate if perfect square
                divisors.append(n // i)

    return sorted(divisors)


def get_sum_of_proper_divisors(n: int) -> int:
    """
    Get the sum of proper divisors of a number.

    Args:
        n: The number

    Returns:
        Sum of proper divisors
    """
    return sum(get_proper_divisors(n))


def find_smallest_amicable_pair() -> tuple[int, int]:
    """
    Find the smallest pair of amicable numbers.

    Returns:
        Tuple of the smallest amicable pair (smaller, larger)
    """
    n = 1

    while True:
        n += 1
        sum1 = get_sum_of_proper_divisors(n)

        # Skip if sum equals the number itself (perfect number)
        if sum1 == n:
            continue

        sum2 = get_sum_of_proper_divisors(sum1)

        # Check if it's an amicable pair
        # sum2 == n means n is the sum of proper divisors of sum1
        # n < sum1 ensures we only get the pair once (smaller number first)
        if sum2 == n and n < sum1:
            return (n, sum1)


def main():
    """Main function to find and print the smallest amicable pair."""
    a, b = find_smallest_amicable_pair()
    print(f"({a},{b})")


if __name__ == "__main__":
    main()
