#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.equal_list(["a", "bc"], ["ab", "c"]))
        self.assertTrue(ch_1.equal_list(["a", "b", "c"], ["a", "bc"]))
        self.assertFalse(ch_1.equal_list(["a", "bc"], ["a", "c", "b"]))
        self.assertTrue(ch_1.equal_list(["ab", "c", ""], ["", "a", "bc"]))
        self.assertTrue(ch_1.equal_list(["p", "e", "r", "l"], ["perl"]))

    def test_ch_2(self):
        self.assertEqual(ch_2.list_division([1,2,3,4,5], 2), [[1,2,3], [4,5]])
        self.assertEqual(ch_2.list_division([1,2,3,4,5,6], 3), [[1,2], [3,4], [5,6]])
        self.assertEqual(ch_2.list_division([1,2,3], 2), [[1,2], [3]])
        self.assertEqual(
            ch_2.list_division([1,2,3,4,5,6,7,8,9,10], 5),
            [[1,2], [3,4], [5,6], [7,8], [9,10]]
        )
        self.assertEqual(ch_2.list_division([1,2,3], 4), None)
        self.assertEqual(
            ch_2.list_division([72,57,89,55,36,84,10,95,99,35], 7),
            [[72,57], [89,55], [36,84], [10], [95], [99], [35]]
        )


if __name__ == "__main__":
    unittest.main()
