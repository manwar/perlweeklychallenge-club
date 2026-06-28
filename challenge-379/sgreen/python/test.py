#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.reverse_string(""), "")
        self.assertEqual(ch_1.reverse_string("reverse the given string"), "gnirts nevig eht esrever")
        self.assertEqual(ch_1.reverse_string("Perl is Awesome"), "emosewA si lreP")
        self.assertEqual(ch_1.reverse_string("v1.0.0-Beta!"), "!ateB-0.0.1v")
        self.assertEqual(ch_1.reverse_string("racecar"), "racecar")

    def test_ch_2(self):
        result_1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407]
        result_2 = [0, 1, 2, 3, 4, 5, 6, 10, 25, 32, 45, 133, 134, 152, 250]
        result_3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 342, 371, 520, 584, 645]

        self.assertEqual(ch_2.armstrong_numbers(10, 1000), result_1)
        self.assertEqual(ch_2.armstrong_numbers(7, 1000), result_2)
        self.assertEqual(ch_2.armstrong_numbers(16, 1000), result_3)


if __name__ == "__main__":
    unittest.main()
