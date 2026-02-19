#!/usr/bin/env python3
"""
Perl Weekly Challenge 049 - Task 1: Smallest Multiple

Given a positive integer N, find the smallest positive multiple of N that
consists only of digits 0 and 1.

This uses a BFS over remainders modulo N to avoid huge integers.
"""

from __future__ import annotations

from collections import deque
from typing import Deque, Dict, List, Sequence, Tuple


def smallest_multiple_01(n: int) -> str:
    """Return the smallest multiple of `n` consisting only of digits 0 and 1."""
    if n <= 0:
        raise ValueError("n must be positive")

    start = 1 % n
    if start == 0:
        return "1"

    parent: Dict[int, int] = {start: -1}
    digit: Dict[int, str] = {start: "1"}

    q: Deque[int] = deque([start])
    while q:
        r = q.popleft()
        for d in ("0", "1"):
            nr = (r * 10 + (1 if d == "1" else 0)) % n
            if nr in parent:
                continue
            parent[nr] = r
            digit[nr] = d
            if nr == 0:
                out: List[str] = []
                cur = nr
                while cur != -1:
                    out.append(digit[cur])
                    cur = parent[cur]
                return "".join(reversed(out))
            q.append(nr)

    raise RuntimeError("no solution found (unexpected)")


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1:
        raise SystemExit(f"Usage: {__file__} <N>")
    print(smallest_multiple_01(int(argv[0])))


def _run_tests() -> None:
    import unittest

    class TestChallenge049Task1(unittest.TestCase):
        def test_example(self) -> None:
            self.assertEqual(smallest_multiple_01(55), "110")

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge049Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])

