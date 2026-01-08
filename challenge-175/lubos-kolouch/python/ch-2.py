#!/usr/bin/env python3
"""Perfect Totient Numbers - Perl Weekly Challenge 175 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def totients_up_to(limit: int) -> list[int]:
    """Compute Euler totient function for 0..limit using a sieve."""
    phi = list(range(limit + 1))
    for p in range(2, limit + 1):
        if phi[p] != p:  # not prime
            continue
        for k in range(p, limit + 1, p):
            phi[k] -= phi[k] // p
    return phi


def perfect_totient_numbers(count: int) -> list[int]:
    """Return first `count` perfect totient numbers."""
    if count <= 0:
        raise ValueError("Expected count > 0")

    # The specification gives the first 20 numbers and the 20th is 5571.
    limit = 5571
    phi = totients_up_to(limit)

    out: list[int] = []
    for n in range(2, limit + 1):
        total = 0
        x = n
        while x > 1:
            x = phi[x]
            total += x
        if total == n:
            out.append(n)
            if len(out) == count:
                return out

    raise ValueError(f"Unable to find {count} perfect totient numbers up to {limit}")


class PerfectTotientExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_first_20(self) -> None:
        self.assertEqual(
            perfect_totient_numbers(20),
            [
                3,
                9,
                15,
                27,
                39,
                81,
                111,
                183,
                243,
                255,
                327,
                363,
                471,
                729,
                2187,
                2199,
                3063,
                4359,
                4375,
                5571,
            ],
        )


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit("Usage: python3 ch-2.py  # run tests (spec only)")


if __name__ == "__main__":
    main()
