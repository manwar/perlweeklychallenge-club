import unittest

from oddoneout import *

class TestNotAlphaOrder(unittest.TestCase):

    def test_order_one(self):
        self.assertFalse(is_not_alpha_order('abc'))
    def test_order_two(self):
        self.assertTrue(is_not_alpha_order('cba'))

class TestCount(unittest.TestCase):
    def test_count_example_one(self):
        words = ['abc', 'xyz', 'tsu']
        self.assertEqual(count(words),1)
    def test_count_example_two(self):
        words = ['rat', 'cab', 'dad']
        self.assertEqual(count(words),3)
    def test_count_example_three(self):
        words = ['x', 'y', 'z']
        self.assertEqual(count(words),0)

if __name__ == '__main__':
    unittest.main()
