#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.kolakoski_sequence(4), 2)
        self.assertEqual(ch_1.kolakoski_sequence(5), 3)
        self.assertEqual(ch_1.kolakoski_sequence(6), 3)
        self.assertEqual(ch_1.kolakoski_sequence(7), 4)
        self.assertEqual(ch_1.kolakoski_sequence(8), 4)


    def test_ch_2(self):
        def s(winner, loser):
            return f"Team {winner} defeated Team {loser}"
        self.assertEqual(ch_2.who_wins("HAHAHH"), s(2, 6))
        self.assertEqual(ch_2.who_wins("HHHHHH"), s(1, 2))
        self.assertEqual(ch_2.who_wins("HHHAHA"), s(4, 2))
        self.assertEqual(ch_2.who_wins("HAHAAH"), s(4, 6))
        self.assertEqual(ch_2.who_wins("HAAHAA"), s(5, 1))


if __name__ == "__main__":
    unittest.main()
