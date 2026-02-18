#!/usr/bin/env python3
"""
Perl Weekly Challenge 058 - Task 1: Compare Version

Compare two version strings containing digits, '.' and '_' such that:
- return 1  if v1 > v2
- return -1 if v1 < v2
- return 0  if equal

Rule: '_' denotes an alpha/development separator and has lower precedence than '.'
when numeric components are equal (see examples in the spec).
"""

from __future__ import annotations

from typing import List, Sequence, Tuple


def _parse_version(ver: str) -> Tuple[List[int], List[str]]:
    if any(ch not in "0123456789._" for ch in ver) or not ver:
        raise ValueError("invalid version string")

    nums: List[int] = []
    seps: List[str] = []
    current = ""
    for ch in ver:
        if ch.isdigit():
            current += ch
        else:
            if current == "":
                raise ValueError("invalid version string")
            nums.append(int(current))
            current = ""
            seps.append(ch)
    if current == "":
        raise ValueError("invalid version string")
    nums.append(int(current))

    return nums, seps


def compare_versions(v1: str, v2: str) -> int:
    """Compare v1 and v2 according to the challenge rules."""
    nums1, seps1 = _parse_version(v1)
    nums2, seps2 = _parse_version(v2)

    m = min(len(nums1), len(nums2))
    for i in range(m):
        if nums1[i] != nums2[i]:
            return 1 if nums1[i] > nums2[i] else -1
        if i > 0 and seps1[i - 1] != seps2[i - 1]:
            return 1 if seps1[i - 1] == "." else -1

    if len(nums1) != len(nums2):
        return 1 if len(nums1) > len(nums2) else -1
    return 0


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 2:
        raise SystemExit(f"Usage: {__file__} <v1> <v2>")
    print(compare_versions(argv[0], argv[1]))


def _run_tests() -> None:
    import unittest

    class TestChallenge058Task1(unittest.TestCase):
        def test_examples(self) -> None:
            self.assertEqual(compare_versions("0.1", "1.1"), -1)
            self.assertEqual(compare_versions("2.0", "1.2"), 1)
            self.assertEqual(compare_versions("1.2", "1.2_5"), -1)
            self.assertEqual(compare_versions("1.2.1", "1.2_1"), 1)
            self.assertEqual(compare_versions("1.2.1", "1.2.1"), 0)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge058Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
