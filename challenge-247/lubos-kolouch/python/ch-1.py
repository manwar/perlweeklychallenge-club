#!/usr/bin/env python3
"""Secret Santa - Perl Weekly Challenge 247, Task 1."""

from __future__ import annotations

from collections import defaultdict
import random
import unittest


def family_name(name: str) -> str:
    """Return the family name (trailing word) from a participant's full name."""
    parts = name.split()
    return parts[-1] if parts else name


def secret_santa(names: list[str]) -> dict[str, str]:
    """Return a Secret Santa assignment minimizing same-family pairs."""
    n = len(names)
    if n == 0:
        return {}

    shuffled = random.sample(names, n)
    by_family: dict[str, list[str]] = defaultdict(list)
    for name in shuffled:
        by_family[family_name(name)].append(name)

    families = sorted(by_family.keys(), key=lambda f: (-len(by_family[f]), f))
    ordered = [member for fam in families for member in by_family[fam]]

    circle = [""] * n
    idx = 0
    for pos in range(0, n, 2):
        circle[pos] = ordered[idx]
        idx += 1
    for pos in range(1, n, 2):
        circle[pos] = ordered[idx]
        idx += 1

    return {circle[i]: circle[(i + 1) % n] for i in range(n)}


class TestSecretSanta(unittest.TestCase):
    """Unit tests for the secret_santa function."""

    def test_example_1(self) -> None:
        """Verify assignment with no same-family pairs is found."""
        names = [
            "Mr. Wall",
            "Mrs. Wall",
            "Mr. Anwar",
            "Mrs. Anwar",
            "Mr. Conway",
            "Mr. Cross",
        ]
        res = secret_santa(names)
        self.assertEqual(set(res.keys()), set(names))
        self.assertEqual(set(res.values()), set(names))
        self.assertTrue(all(g != r for g, r in res.items()))
        same_family = sum(1 for g, r in res.items() if family_name(g) == family_name(r))
        self.assertEqual(same_family, 0)

    def test_example_2(self) -> None:
        """Verify assignment minimizes same-family pairs when unavoidable."""
        names = ["Mr. Wall", "Mrs. Wall", "Mr. Anwar"]
        res = secret_santa(names)
        self.assertEqual(set(res.keys()), set(names))
        self.assertEqual(set(res.values()), set(names))
        self.assertTrue(all(g != r for g, r in res.items()))
        same_family = sum(1 for g, r in res.items() if family_name(g) == family_name(r))
        self.assertEqual(same_family, 1)


if __name__ == "__main__":
    unittest.main()
