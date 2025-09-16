#!/usr/bin/env python3
"""
The Weekly Challenge 339 Task 2: Peak Point

Given a list of altitude gain values, compute the running cumulative altitude
starting from zero and return the highest altitude reached at any step.
"""
import unittest

GainList = list[int]


def peak_point(gain: GainList) -> int:
    """Return the maximum altitude reached given incremental gains."""
    altitude = 0
    peak = 0
    for delta in gain:
        altitude += delta
        if altitude > peak:
            peak = altitude
    return peak


class TestPeakPoint(unittest.TestCase):
    """Unit tests covering the provided examples."""

    def test_example1(self) -> None:
        gain = [-5, 1, 5, -9, 2]
        self.assertEqual(peak_point(gain), 1)

    def test_example2(self) -> None:
        gain = [10, 10, 10, -25]
        self.assertEqual(peak_point(gain), 30)

    def test_example3(self) -> None:
        gain = [3, -4, 2, 5, -6, 1]
        self.assertEqual(peak_point(gain), 6)

    def test_example4(self) -> None:
        gain = [-1, -2, -3, -4]
        self.assertEqual(peak_point(gain), 0)

    def test_example5(self) -> None:
        gain = [-10, 15, 5]
        self.assertEqual(peak_point(gain), 10)


if __name__ == "__main__":
    unittest.main()
