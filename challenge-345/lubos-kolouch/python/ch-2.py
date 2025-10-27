"""Last Visitor Challenge Solution.

Process a mixed sequence of positive integers and ``-1`` sentinel values to
report, for each ``-1``, which previously seen visitor should be returned.
"""

from collections.abc import Iterable, Sequence
import unittest


def last_visitor(ints: Sequence[int]) -> list[int]:
    """Return the lookups requested by ``-1`` entries in ``ints``.

    Positive integers are stored with the newest at index 0. For a run of
    ``-1`` values, the ``x``-th ``-1`` retrieves the ``x``-th element of the
    stored list (if present) or ``-1`` otherwise.
    """
    seen: list[int] = []
    answers: list[int] = []
    neg_run = 0

    for value in ints:
        if value == -1:
            answers.append(seen[neg_run] if neg_run < len(seen) else -1)
            neg_run += 1
            continue

        seen.insert(0, value)
        neg_run = 0

    return answers


class LastVisitorTests(unittest.TestCase):
    """Unit tests restricted to the specification examples."""

    def _assert_example(self, data: Iterable[int],
                        expected: list[int]) -> None:
        self.assertEqual(last_visitor(list(data)), expected)

    def test_example_1(self) -> None:
        self._assert_example((5, -1, -1), [5, -1])

    def test_example_2(self) -> None:
        self._assert_example((3, 7, -1, -1, -1), [7, 3, -1])

    def test_example_3(self) -> None:
        self._assert_example((2, -1, 4, -1, -1), [2, 4, 2])

    def test_example_4(self) -> None:
        self._assert_example((10, 20, -1, 30, -1, -1), [20, 30, 20])

    def test_example_5(self) -> None:
        self._assert_example((-1, -1, 5, -1), [-1, -1, 5])


if __name__ == "__main__":
    unittest.main()
