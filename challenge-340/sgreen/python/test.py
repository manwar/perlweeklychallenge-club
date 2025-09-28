#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.duplicate_removals('abbaca'), 'ca')
        self.assertEqual(ch_1.duplicate_removals('azxxzy'), 'ay')
        self.assertEqual(ch_1.duplicate_removals('aaaaaaaa'), '')
        self.assertEqual(ch_1.duplicate_removals('aabccba'), 'a')
        self.assertEqual(ch_1.duplicate_removals('abcddcba'), '')

    def test_ch_2(self):
        self.assertTrue(ch_2.ascending_numbers('The cat has 3 kittens 7 toys 10 beds'))
        self.assertFalse(ch_2.ascending_numbers('Alice bought 5 apples 2 oranges 9 bananas'))
        self.assertTrue(ch_2.ascending_numbers('I ran 1 mile 2 days 3 weeks 4 months'))
        self.assertFalse(ch_2.ascending_numbers('Bob has 10 cars 10 bikes'))
        self.assertTrue(ch_2.ascending_numbers('Zero is 0 one is 1 two is 2'))


if __name__ == '__main__':
    unittest.main()
