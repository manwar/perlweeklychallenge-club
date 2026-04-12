#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.make_it_bigger(15456, 5), 1546)
        self.assertEqual(ch_1.make_it_bigger(7332, 3), 732)
        self.assertEqual(ch_1.make_it_bigger(2231, 2), 231)
        self.assertEqual(ch_1.make_it_bigger(543251, 5), 54321)
        self.assertEqual(ch_1.make_it_bigger(1921, 1), 921)

    def test_ch_2(self):
        self.assertEqual(ch_2.omega(100061, 0), 3)
        self.assertEqual(ch_2.omega(971088, 0), 3)
        self.assertEqual(ch_2.omega(63640, 1), 6)
        self.assertEqual(ch_2.omega(988841, 1), 2)
        self.assertEqual(ch_2.omega(211529, 0), 2)


if __name__ == "__main__":
    unittest.main()
