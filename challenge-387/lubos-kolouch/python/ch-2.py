#!/usr/bin/env python3
"""Perl Weekly Challenge 387 - Task 2: Atoms Count.

Given a chemical formula with nested parentheses and multipliers, count each atom
and return the result sorted alphabetically, omitting multiplier 1.
"""

from __future__ import annotations

import unittest
from collections import defaultdict


def count_atoms(formula: str) -> str:
    """Parse a chemical formula and return sorted element counts as a string.

    :param formula: Chemical formula string with nested parentheses and numbers.
    :return: Alphabetically sorted string of elements and their counts (>1).
    """
    stack: list[dict[str, int]] = [defaultdict(int)]
    i = 0
    n = len(formula)

    while i < n:
        char = formula[i]

        if char == "(":
            stack.append(defaultdict(int))
            i += 1
        elif char == ")":
            i += 1
            start = i
            while i < n and formula[i].isdigit():
                i += 1
            mult_str = formula[start:i]
            mult = int(mult_str) if mult_str else 1

            top = stack.pop()
            for elem, count in top.items():
                stack[-1][elem] += count * mult
        elif char.isupper():
            start_elem = i
            i += 1
            while i < n and formula[i].islower():
                i += 1
            elem = formula[start_elem:i]

            start_num = i
            while i < n and formula[i].isdigit():
                i += 1
            mult_str = formula[start_num:i]
            mult = int(mult_str) if mult_str else 1

            stack[-1][elem] += mult
        else:
            raise ValueError(f"Unexpected character '{char}' at index {i}")

    counts = stack[0]
    result_parts: list[str] = []
    for elem in sorted(counts.keys()):
        result_parts.append(elem)
        if counts[elem] > 1:
            result_parts.append(str(counts[elem]))

    return "".join(result_parts)


class TestAtomsCount(unittest.TestCase):
    """Test cases for count_atoms."""

    def test_example_1(self) -> None:
        self.assertEqual(count_atoms("((N2O)3(H2O)2)2"), "H8N12O10")

    def test_example_2(self) -> None:
        self.assertEqual(count_atoms("Mg3(PO4)2"), "Mg3O8P2")

    def test_example_3(self) -> None:
        self.assertEqual(count_atoms("(((H)2)3)4"), "H24")

    def test_example_4(self) -> None:
        self.assertEqual(count_atoms("NaCl3(O2(S10)2)2Mg"), "Cl3MgNaO4S40")

    def test_example_5(self) -> None:
        self.assertEqual(count_atoms("Z2Y3(X2W)2"), "W2X4Y3Z2")


if __name__ == "__main__":
    unittest.main()
