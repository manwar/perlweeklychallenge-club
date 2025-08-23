#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.common_characters(["bella", "label", "roller"]), ["e", "l", "l"])
        self.assertEqual(ch_1.common_characters(["cool", "lock", "cook"]), ["c", "o"])
        self.assertEqual(ch_1.common_characters(["hello", "world", "pole"]), ["l", "o"])
        self.assertEqual(ch_1.common_characters(["abc", "def", "ghi"]), [])
        self.assertEqual(ch_1.common_characters(["aab", "aac", "aaa"]), ["a", "a"])

    def test_ch_2(self):
        moves_1 = [[0,0],[2,0],[1,1],[2,1],[2,2]]
        moves_2 = [[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]]
        moves_3 = [[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]]
        moves_4 = [[0,0],[1,1]]
        moves_5 = [[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]]
        self.assertEqual(ch_2.find_winner(moves_1), "A")
        self.assertEqual(ch_2.find_winner(moves_2), "B")
        self.assertEqual(ch_2.find_winner(moves_3), "Draw")
        self.assertEqual(ch_2.find_winner(moves_4), "Pending")
        self.assertEqual(ch_2.find_winner(moves_5), "B")


if __name__ == '__main__':
    unittest.main()
