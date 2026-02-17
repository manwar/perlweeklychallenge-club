#!/usr/bin/env python3
"""
Perl Weekly Challenge 090 - Task 1: DNA Sequence

You are given a DNA sequence:
  GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG

Print the nucleobase counts and the complementary sequence using the mapping:
  T -> A
  A -> T
  G -> C
  C -> G
"""

from __future__ import annotations

from collections import Counter
from typing import Dict, Sequence, Tuple

DNA_SEQUENCE = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG"


def nucleobase_counts_and_complement(seq: str) -> Tuple[Dict[str, int], str]:
    """Return ({base: count}, complement_sequence) for the given DNA `seq`."""
    complement_map = {"T": "A", "A": "T", "G": "C", "C": "G"}
    counts = Counter(seq)
    complement = "".join(complement_map[ch] for ch in seq)
    return dict(counts), complement


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    seq = argv[0]
    counts, complement = nucleobase_counts_and_complement(seq)
    for base in "ACGT":
        print(f"{base}: {counts.get(base, 0)}")
    print(complement)


def _run_tests() -> None:
    import unittest

    class TestChallenge090Task1(unittest.TestCase):
        def test_complement_sequence(self) -> None:
            counts, complement = nucleobase_counts_and_complement(DNA_SEQUENCE)
            self.assertEqual(
                complement,
                "CATTTGGGGAAAAGTAAATCTGTCTAGCTGAGGAATAGGTAAGAGTCTCTACACAACGACCAGCGGC",
            )
            self.assertEqual(counts["A"], 14)
            self.assertEqual(counts["C"], 18)
            self.assertEqual(counts["G"], 13)
            self.assertEqual(counts["T"], 22)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge090Task1)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
