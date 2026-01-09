#!/usr/bin/env python3
"""Prime Partition - Perl Weekly Challenge task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_prime(x: int) -> bool:
    """Check if x is prime."""
    if x < 2:
        return False
    for i in range(2, int(x**0.5) + 1):
        if x % i == 0:
            return False
    return True


def find_prime_partition(m: int,
                         n: int,
                         start: int = 2,
                         current: list[int] | None = None) -> str | None:
    """Recursive backtracking to find one prime partition."""
    if current is None:
        current = []
    if n == 0:
        return ",".join(map(str, current)) if m == 0 else None
    for p in range(max(start, 2), m + 1):
        if is_prime(p):
            result = find_prime_partition(m - p, n - 1, p + 1, current + [p])
            if result is not None:
                return result
    return None


def prime_partition(m: int, n: int) -> str:
    """Return one valid prime partition as comma-separated string."""
    if m <= 0 or n <= 0:
        raise ValueError("m and n must be positive integers")
    result = find_prime_partition(m, n)
    if result is None:
        raise ValueError(f"No prime partition exists for m={m}, n={n}")
    return result


class PrimePartitionExamples(unittest.TestCase):
    """Tests based on challenge examples."""

    def test_example_1(self) -> None:
        possibilities = {"5,13", "7,11"}
        got = prime_partition(18, 2)
        self.assertIn(got, possibilities)

    def test_example_2(self) -> None:
        self.assertEqual(prime_partition(19, 3), "3,5,11")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 2:
        raise SystemExit("Usage: python3 ch-1.py <m> <n>")
    m, n = int(args[0]), int(args[1])
    print(f"Input:  $m = {m}, $n = {n}")
    print(f"Output: {prime_partition(m, n)}")


if __name__ == "__main__":
    main()
