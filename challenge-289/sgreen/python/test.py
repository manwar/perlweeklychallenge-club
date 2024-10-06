#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.third_maximum([4, 6, 5, 1]), 4)
        self.assertEqual(ch_1.third_maximum([4, 5]), 5)
        self.assertEqual(ch_1.third_maximum([1, 2, 2, 3]), 1)


    def test_ch_2(self):
        word1 = 'The quick brown fox jumps over the lazy dog.'
        regex1 = r'^The q[uic]{3}k b[row]{3}n fox j[ump]{3}s o[ve]{2}r the l[az]{2}y dog\.$'

        word2 = 'Perl is very much alive!!'
        regex2 = '^P[er]{2}l is v[er]{2}y m[uc]{2}h a[liv]{3}e!!$'

        self.assertRegex(ch_2.jumbled_letters(word1), regex1)
        self.assertRegex(ch_2.jumbled_letters(word2), regex2)


if __name__ == '__main__':
    unittest.main()
