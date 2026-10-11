#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.alt_case("aAbB"), 0)
        self.assertEqual(ch_1.alt_case("AAbb"), 1)
        self.assertEqual(ch_1.alt_case("AAAbbb"), 3)
        self.assertEqual(ch_1.alt_case("aABb"), 1)
        self.assertEqual(ch_1.alt_case("bBBAaa"), 2)

    def test_ch_2(self):
        self.assertEqual(ch_2.alt_vc(["relocate", "delocate", "allocate"]), ["locate"])
        self.assertEqual(ch_2.alt_vc(["apple", "banana", "cherry"]), [])
        self.assertEqual(ch_2.alt_vc(["navigate", "cavity", "gravity"]), ["avi"])
        self.assertEqual(ch_2.alt_vc(["pedalgia", "pedalboard", "pedantic"]), ["peda"])
        self.assertEqual(ch_2.alt_vc(["schoolmaster", "schoolhouse", "schooling"]), ["ho", "ol"])


if __name__ == "__main__":
    unittest.main()
