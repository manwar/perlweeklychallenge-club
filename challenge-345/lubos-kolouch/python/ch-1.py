"""Peak Positions Challenge Solution.

This module implements the Weekly Challenge task that asks for all peak
indices in a sequence of integers. Peaks are elements strictly greater than
neighbours, with the endpoints compared against their single neighbour.
"""

from collections.abc import Iterable, Sequence
import unittest


def peak_positions(ints: Sequence[int]) -> list[int]:
    """Return the zero-based indices of every peak in ``ints``.

    Args:
        ints: Sequence of integers to analyse.

    Returns:
        A list of indices at which the element is strictly greater than its
        immediate neighbour(s).
    """
    peaks: list[int] = []
    last_index = len(ints) - 1

    for idx, value in enumerate(ints):
        left = ints[idx - 1] if idx > 0 else None
        right = ints[idx + 1] if idx < last_index else None

        if left is not None and value <= left:
            continue
        if right is not None and value <= right:
            continue
        peaks.append(idx)

    return peaks


class PeakPositionsTests(unittest.TestCase):
    """Unit tests restricted to the specification examples."""

    def _assert_example(self, data: Iterable[int],
                        expected: list[int]) -> None:
        self.assertEqual(peak_positions(list(data)), expected)

    def test_example_1(self) -> None:
        self._assert_example((1, 3, 2), [1])

    def test_example_2(self) -> None:
        self._assert_example((2, 4, 6, 5, 3), [2])

    def test_example_3(self) -> None:
        self._assert_example((1, 2, 3, 2, 4, 1), [2, 4])

    def test_example_4(self) -> None:
        self._assert_example((5, 3, 1), [0])

    def test_example_5(self) -> None:
        self._assert_example((1, 5, 1, 5, 1, 5, 1), [1, 3, 5])


if __name__ == "__main__":
    unittest.main()
