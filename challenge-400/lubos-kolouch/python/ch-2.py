#!/usr/bin/env python3
"""Minimum Genetic Mutation - Perl Weekly Challenge 400, Task 2."""

from __future__ import annotations

from collections import deque
import unittest


def min_genetic_mutation(start_gene: str, end_gene: str, gene_bank: list[str]) -> int:
    """Return the minimum mutations from start_gene to end_gene, or -1."""
    if start_gene == end_gene:
        return 0

    bank = set(gene_bank)
    if end_gene not in bank:
        return -1

    queue: deque[tuple[str, int]] = deque([(start_gene, 0)])
    visited = {start_gene}

    while queue:
        gene, steps = queue.popleft()
        for pos, orig in enumerate(gene):
            for base in "ACGT":
                if base == orig:
                    continue
                next_gene = f"{gene[:pos]}{base}{gene[pos + 1 :]}"
                if next_gene == end_gene:
                    return steps + 1
                if next_gene in bank and next_gene not in visited:
                    visited.add(next_gene)
                    queue.append((next_gene, steps + 1))

    return -1


class TestMinGeneticMutation(unittest.TestCase):
    """Unit tests for the min_genetic_mutation function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[str, str, list[str], int]] = [
            ("AACCGGTT", "AACCGGTA", ["AACCGCTA", "AAACGGTA"], -1),
            (
                "AACCGGTT",
                "AACCGGAA",
                ["AACCGGTA", "AACCGGAA", "AACCGCTA", "AACCCTAA", "AACCGTAA"],
                2,
            ),
            ("AAAAAAAA", "AAAAACCC", ["CAAAAAAA", "CCAAAAAA", "AAAAAAAC"], -1),
            (
                "GAAAAAAA",
                "GCCCCCCC",
                [
                    "GCAAAAAA",
                    "GCCAAAAA",
                    "GCCCAAAA",
                    "GCCCCAAA",
                    "GCCCCCAA",
                    "GCCCCCCA",
                    "GCCCCCCC",
                ],
                7,
            ),
            ("AACCGGTT", "AACCGGTT", ["AACCGGTA"], 0),
        ]
        for start_gene, end_gene, gene_bank, expected in cases:
            with self.subTest(start_gene=start_gene, end_gene=end_gene):
                self.assertEqual(
                    min_genetic_mutation(start_gene, end_gene, gene_bank), expected
                )


if __name__ == "__main__":
    unittest.main()
