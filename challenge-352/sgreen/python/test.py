#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.match_string(["cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"]),
            ["cat", "dog", "dogcat", "rat"]
        )
        self.assertEqual(
            ch_1.match_string(["hello", "hell", "world", "wor", "ellow", "elloworld"]),
            ["hell", "world", "wor", "ellow"]
        )
        self.assertEqual(
            ch_1.match_string(["a", "aa", "aaa", "aaaa"]),
            ["a", "aa", "aaa"]
        )
        self.assertEqual(
            ch_1.match_string(["flower", "flow", "flight", "fl", "fli", "ig", "ght"]),
            ["flow", "fl", "fli", "ig", "ght"]
        )
        self.assertEqual(
            ch_1.match_string(["car", "carpet", "carpenter", "pet", "enter", "pen", "pent"]),
            ["car", "pet", "enter", "pen", "pent"]
        )

    def test_ch_2(self):
        result_1 = [True, False, False, False, False, True, True, False, False, False]
        result_2 = [False, False, True, True, False, False]
        result_3 = [True, True, False, False, True]
        result_4 = [False, False, False, True, False]
        result_5 = [False, False, True, False, False, True, True, True, False, False]

        self.assertEqual(ch_2.binary_prefix([0,1,1,0,0,1,0,1,1,1]), result_1)
        self.assertEqual(ch_2.binary_prefix([1,0,1,0,1,0]), result_2)
        self.assertEqual(ch_2.binary_prefix([0,0,1,0,1]), result_3)
        self.assertEqual(ch_2.binary_prefix([1,1,1,1,1]), result_4)
        self.assertEqual(ch_2.binary_prefix([1,0,1,1,0,1,0,0,1,1]), result_5)


if __name__ == '__main__':
    unittest.main()
