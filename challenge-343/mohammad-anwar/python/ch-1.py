#!/usr/bin/env python3

import unittest

def zero_friend(nums):
    return min(map(abs, nums))

class TestZeroFriend(unittest.TestCase):
    def test_examples(self):
        examples = [
            {'input': [4, 2, -1, 3, -2],     'exp': 1},
            {'input': [-5, 5, -3, 3, -1, 1], 'exp': 1},
            {'input': [7, -3, 0, 2, -8],     'exp': 0},
            {'input': [-2, -5, -1, -8],      'exp': 1},
            {'input': [-2, 2, -4, 4, -1, 1], 'exp': 1},
        ]

        for example in examples:
            with self.subTest(input=example['input']):
                self.assertEqual(zero_friend(example['input']), example['exp'])

if __name__ == '__main__':
    unittest.main()
