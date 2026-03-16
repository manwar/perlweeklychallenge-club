#!/usr/bin/env python3
import unittest


def goal_parser(s: str) -> str:
    return s.replace("(al)", "al").replace("()", "o")


class TestGoalParser(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(goal_parser("G()(al)"), "Goal")
        self.assertEqual(goal_parser("G()()()()(al)"), "Gooooal")
        self.assertEqual(goal_parser("(al)G(al)()()G"), "alGalooG")


if __name__ == "__main__":
    unittest.main()
