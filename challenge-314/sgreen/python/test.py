#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.equal_strings(['abc', 'abb', 'ab']), 2)
        self.assertEqual(ch_1.equal_strings(['ayz' 'cyz', 'xyz']), -1)
        self.assertEqual(ch_1.equal_strings(['yza', 'yzb', 'yzc']), 3)

    def test_ch_2(self):
        self.assertEqual(ch_2.sort_column(["swpc", "tyad", "azbe"]), 2)
        self.assertEqual(ch_2.sort_column(["cba", "daf", "ghi"]), 1)
        self.assertEqual(ch_2.sort_column(["a", "b", "c"]), 0)


if __name__ == '__main__':
    unittest.main()
