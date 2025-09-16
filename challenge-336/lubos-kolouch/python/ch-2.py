#!/usr/bin/env python3
"""The Weekly Challenge 336 Task 2: Final Score."""
import unittest

ScoreList = list[str]


def final_score(scores: ScoreList) -> int:
    """Calculate the total score from a list of operations."""
    record: list[int] = []
    for entry in scores:
        if entry == "C":
            record.pop()
        elif entry == "D":
            record.append(2 * record[-1])
        elif entry == "+":
            record.append(record[-1] + record[-2])
        else:
            record.append(int(entry))
    return sum(record)


class TestFinalScore(unittest.TestCase):
    """Unit tests derived from the specification examples."""

    def test_example1(self) -> None:
        self.assertEqual(final_score(["5", "2", "C", "D", "+"]), 30)

    def test_example2(self) -> None:
        self.assertEqual(
            final_score(["5", "-2", "4", "C", "D", "9", "+", "+"]), 27)

    def test_example3(self) -> None:
        self.assertEqual(final_score(["7", "D", "D", "C", "+", "3"]), 45)

    def test_example4(self) -> None:
        self.assertEqual(final_score(["-5", "-10", "+", "D", "C", "+"]), -55)

    def test_example5(self) -> None:
        self.assertEqual(
            final_score(
                ["3", "6", "+", "D", "C", "8", "+", "D", "-2", "C", "+"]),
            128,
        )


if __name__ == "__main__":
    unittest.main()
