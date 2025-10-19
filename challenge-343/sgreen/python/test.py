#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.zero_friend([4, 2, -1, 3, -2]), 1)
        self.assertEqual(ch_1.zero_friend([-5, 5, -3, 3, -1, 1]), 1)
        self.assertEqual(ch_1.zero_friend([7, -3, 0, 2, -8]), 0)
        self.assertEqual(ch_1.zero_friend([-2, -5, -1, -8]), 1)
        self.assertEqual(ch_1.zero_friend([-2, 2, -4, 4, -1, 1]), 1)
        self.assertEqual(ch_1.zero_friend([1.2, 2, 4, -5]), 1.2)

    def test_ch_2(self):
        matrix_1 = [
            [0, 1, 1],
            [0, 0, 1],
            [0, 0, 0],
        ]

        matrix_2 = [
            [0, 1, 0, 0],
            [0, 0, 0, 0],
            [1, 1, 0, 0],
            [1, 1, 1, 0],
        ]

        matrix_3 = [
            [0, 1, 0, 1],
            [0, 0, 1, 1],
            [1, 0, 0, 0],
            [0, 0, 1, 0],
        ]

        matrix_4 = [
            [0, 1, 1],
            [0, 0, 0],
            [0, 1, 0],
        ]

        matrix_5 = [
            [0, 0, 0, 0, 0],
            [1, 0, 0, 0, 0],
            [1, 1, 0, 1, 1],
            [1, 1, 0, 0, 0],
            [1, 1, 0, 1, 0],
        ]

        matrix_6 = [
            [0, 0, 1, 1],
            [1, 0, 0, 1],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
        ]

        matrix_7 = [
            [0, 1, 0, 1],
            [0, 0, 1, 1],
            [1, 0, 0, 1],
            [0, 0, 0, 0],
        ]

        self.assertEqual(ch_2.champion_team(matrix_1), 'Team 0')
        self.assertEqual(ch_2.champion_team(matrix_2), 'Team 3')
        self.assertEqual(ch_2.champion_team(matrix_3), 'Team 0')
        self.assertEqual(ch_2.champion_team(matrix_4), 'Team 0')
        self.assertEqual(ch_2.champion_team(matrix_5), 'Team 2')
        self.assertEqual(ch_2.champion_team(matrix_6), 'Team 1')
        self.assertEqual(ch_2.champion_team(matrix_7), 'No champion')


if __name__ == '__main__':
    unittest.main()
