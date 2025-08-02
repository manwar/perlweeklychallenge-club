#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.replace_words(["cat", "bat", "rat"],
                               'the cattle was rattle by the battery'),
            'the cat was rat by the bat'
        )
        self.assertEqual(
            ch_1.replace_words(["a", "b", "c"], 'aab aac and cac bab'),
            'a a a c b'
        )
        self.assertEqual(
            ch_1.replace_words(
                ["man", "bike"], 'the manager was hit by a biker'),
            'the man was hit by a bike'
        )

        self.assertEqual(
            ch_1.replace_words(["can"], "they can't swim"),
            'they can swim'
        )

        self.assertEqual(
            ch_1.replace_words(["row"], "the quick brown fox"),
            'the quick brown fox'
        )

    def test_ch_2(self):
        matrix_1 = [
            ["A", "B", "D", "E"],
            ["C", "B", "C", "A"],
            ["B", "A", "A", "D"],
            ["D", "B", "B", "C"],
        ]

        matrix_2 = [
            ["A", "A", "B", "B"],
            ["C", "C", "B", "A"],
            ["C", "A", "A", "A"],
            ["B", "B", "B", "B"],
        ]

        matrix_3 = [
            ["B", "A", "B", "A"],
            ["C", "C", "C", "C"],
            ["A", "B", "A", "B"],
            ["B", "B", "A", "A"],
        ]

        self.assertTrue(ch_2.word_search(matrix_1, 'BDCA'))
        self.assertFalse(ch_2.word_search(matrix_2, 'ABAC'))
        self.assertTrue(ch_2.word_search(matrix_3, 'CCCAA'))


if __name__ == '__main__':
    unittest.main()
