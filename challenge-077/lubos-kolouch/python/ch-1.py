#!/usr/bin/env python3
"""Perl Weekly Challenge 077 - Task 1: Fibonacci Sum.

Find all combinations of unique Fibonacci numbers that sum to N.
"""

from __future__ import annotations

import unittest


def get_fibs_up_to(max_n: int) -> list[int]:
    """Generate all Fibonacci numbers <= max_n starting with 1, 2, in descending order.

    :param max_n: Upper limit for Fibonacci numbers.
    :return: List of Fibonacci numbers in descending order.
    """
    if max_n < 1:
        return []

    fibs = [1, 2]
    while True:
        nxt = fibs[-1] + fibs[-2]
        if nxt > max_n:
            break
        fibs.append(nxt)

    return fibs[::-1]


def find_fibonacci_sums(max_n: int) -> list[list[int]] | int:
    """Find all possible combinations of unique Fibonacci numbers that sum to max_n.

    :param max_n: Target integer sum.
    :return: List of combinations or 0 if none found.
    """
    if max_n < 1:
        return 0

    all_fibs = get_fibs_up_to(max_n)
    solutions: list[list[int]] = []

    def backtrack(idx: int, current_combo: list[int], current_sum: int) -> None:
        if current_sum == max_n:
            solutions.append(current_combo)
            return

        for i in range(idx, len(all_fibs)):
            fib = all_fibs[i]
            if current_sum + fib > max_n:
                continue
            backtrack(i + 1, current_combo + [fib], current_sum + fib)

    backtrack(0, [], 0)
    return solutions if solutions else 0


class TestFibonacciSum(unittest.TestCase):
    """Test cases for find_fibonacci_sums."""

    def test_example_1(self) -> None:
        self.assertEqual(find_fibonacci_sums(6), [[5, 1], [3, 2, 1]])

    def test_example_2(self) -> None:
        self.assertEqual(find_fibonacci_sums(9), [[8, 1], [5, 3, 1]])

    def test_negative(self) -> None:
        self.assertEqual(find_fibonacci_sums(-19), 0)

    def test_sum_4(self) -> None:
        self.assertEqual(find_fibonacci_sums(4), [[3, 1]])


if __name__ == "__main__":
    unittest.main()
