#!/usr/bin/env python3
"""
Perl Weekly Challenge 058 - Task 2: Ordered Lineup

Arrange people in a lineup based on:
- H: unique heights (arbitrary order)
- T: number of taller people in front for each corresponding height

Return one valid lineup (front-to-back), or raise an error if impossible.
"""

from __future__ import annotations

from dataclasses import dataclass
from typing import List, Sequence


@dataclass(frozen=True)
class Person:
    height: int
    taller_in_front: int


def ordered_lineup(heights: Sequence[int], taller_in_front: Sequence[int]) -> List[int]:
    """Return a valid lineup based on `heights` and `taller_in_front`."""
    if len(heights) != len(taller_in_front):
        raise ValueError("mismatched input sizes")

    people = [Person(h, t) for h, t in zip(heights, taller_in_front)]
    people.sort(key=lambda p: p.height, reverse=True)

    line: List[int] = []
    for p in people:
        if p.taller_in_front < 0 or p.taller_in_front > len(line):
            raise ValueError("no solution")
        line.insert(p.taller_in_front, p.height)
    return line


def _run_cli(argv: Sequence[str]) -> None:
    if not argv:
        _run_tests()
        return
    raise SystemExit("Run without arguments to execute the embedded tests.")


def _run_tests() -> None:
    import unittest

    class TestChallenge058Task2(unittest.TestCase):
        def test_small_example(self) -> None:
            h = [2, 6, 4, 5, 1, 3]
            t = [1, 0, 2, 0, 1, 2]
            self.assertEqual(ordered_lineup(h, t), [5, 1, 2, 6, 3, 4])

        def test_64_person_example(self) -> None:
            h = [
                27,
                21,
                37,
                4,
                19,
                52,
                23,
                64,
                1,
                7,
                51,
                17,
                24,
                50,
                3,
                2,
                34,
                40,
                47,
                20,
                8,
                56,
                14,
                16,
                42,
                38,
                62,
                53,
                31,
                41,
                55,
                59,
                48,
                12,
                32,
                61,
                9,
                60,
                46,
                26,
                58,
                25,
                15,
                36,
                11,
                44,
                63,
                28,
                5,
                54,
                10,
                49,
                57,
                30,
                29,
                22,
                35,
                39,
                45,
                43,
                18,
                6,
                13,
                33,
            ]
            t = [
                6,
                41,
                1,
                49,
                38,
                12,
                1,
                0,
                58,
                47,
                4,
                17,
                26,
                1,
                61,
                12,
                29,
                3,
                4,
                11,
                45,
                1,
                32,
                5,
                9,
                19,
                1,
                4,
                28,
                12,
                2,
                2,
                13,
                18,
                19,
                3,
                4,
                1,
                10,
                16,
                4,
                3,
                29,
                5,
                49,
                1,
                1,
                24,
                2,
                1,
                38,
                7,
                7,
                14,
                35,
                25,
                0,
                5,
                4,
                19,
                10,
                13,
                4,
                12,
            ]
            expected = [
                35,
                23,
                5,
                64,
                37,
                9,
                13,
                25,
                16,
                44,
                50,
                40,
                2,
                27,
                36,
                6,
                18,
                54,
                20,
                39,
                56,
                45,
                12,
                47,
                17,
                33,
                55,
                30,
                26,
                51,
                42,
                53,
                49,
                41,
                32,
                15,
                22,
                60,
                14,
                46,
                24,
                59,
                10,
                28,
                62,
                38,
                58,
                63,
                8,
                48,
                4,
                7,
                31,
                19,
                61,
                43,
                57,
                11,
                1,
                34,
                21,
                52,
                29,
                3,
            ]
            self.assertEqual(ordered_lineup(h, t), expected)

    suite = unittest.TestLoader().loadTestsFromTestCase(TestChallenge058Task2)
    result = unittest.TextTestRunner().run(suite)
    if not result.wasSuccessful():
        raise SystemExit(1)


if __name__ == "__main__":
    import sys

    _run_cli(sys.argv[1:])
