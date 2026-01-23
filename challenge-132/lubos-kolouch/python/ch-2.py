#!/usr/bin/env python3
"""
Perl Weekly Challenge 132 - Task 2: Hash Join

Implement a classic hash join between two relations (lists of rows).

The example joins:
  player_ages  on index 1 (name)
  player_names on index 0 (name)
and outputs (age, name, surname) in the same order as shown in the spec.
"""

from __future__ import annotations

from typing import Any, Dict, List, Sequence, Tuple


Row = List[Any]


def hash_join(build: List[Row], probe: List[Row], build_index: int, probe_index: int) -> List[Row]:
    """
    Return joined rows for build/probe inputs using the given key indexes.

    Output ordering matches the challenge example: group by join key in the
    order of first appearance in the probe input; within each key, preserve
    row order in each input, and emit the Cartesian product.
    """
    build_map: Dict[Any, List[Row]] = {}
    for row in build:
        build_map.setdefault(row[build_index], []).append(row)

    probe_map: Dict[Any, List[Row]] = {}
    key_order: List[Any] = []
    seen: set[Any] = set()
    for row in probe:
        key = row[probe_index]
        probe_map.setdefault(key, []).append(row)
        if key not in seen:
            seen.add(key)
            key_order.append(key)

    out: List[Row] = []
    for key in key_order:
        if key not in build_map:
            continue
        for brow in build_map[key]:
            for prow in probe_map.get(key, []):
                out.append([*brow, *prow[1:]])
    return out


def _example_data() -> Tuple[List[Row], List[Row]]:
    player_ages: List[Row] = [
        [20, "Alex"],
        [28, "Joe"],
        [38, "Mike"],
        [18, "Alex"],
        [25, "David"],
        [18, "Simon"],
    ]
    player_names: List[Row] = [
        ["Alex", "Stewart"],
        ["Joe", "Root"],
        ["Mike", "Gatting"],
        ["Joe", "Blog"],
        ["Alex", "Jones"],
        ["Simon", "Duane"],
    ]
    return player_ages, player_names


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    if len(argv) != 1 or argv[0] != "run":
        raise SystemExit(f"Usage: {__file__} run")

    ages, names = _example_data()
    rows = hash_join(ages, names, 1, 0)
    for r in rows:
        print(", ".join([str(r[0]), f'\"{r[1]}\"', f'\"{r[2]}\"']))


def _run_tests() -> None:
    import unittest

    class TestChallenge132Task2(unittest.TestCase):
        def test_example(self) -> None:
            ages, names = _example_data()
            self.assertEqual(
                hash_join(ages, names, 1, 0),
                [
                    [20, "Alex", "Stewart"],
                    [20, "Alex", "Jones"],
                    [18, "Alex", "Stewart"],
                    [18, "Alex", "Jones"],
                    [28, "Joe", "Root"],
                    [28, "Joe", "Blog"],
                    [38, "Mike", "Gatting"],
                    [18, "Simon", "Duane"],
                ],
            )

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge132Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
