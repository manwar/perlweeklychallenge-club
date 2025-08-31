#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertTrue(ch_1.equal_group([1,1,2,2,2,2]))
        self.assertFalse(ch_1.equal_group([1,1,1,2,2,2,3,3]))
        self.assertTrue(ch_1.equal_group([5,5,5,5,5,5,7,7,7,7,7,7]))
        self.assertFalse(ch_1.equal_group([1,2,3,4]))
        self.assertTrue(ch_1.equal_group([8,8,9,9,10,10,11,11]))

    def test_ch_2(self):
        self.assertEqual(ch_2.final_score(["5","2","C","D","+"]), 30)
        self.assertEqual(ch_2.final_score(["5","-2","4","C","D","9","+","+"]), 27)
        self.assertEqual(ch_2.final_score(["7","D","D","C","+","3"]), 45)
        self.assertEqual(ch_2.final_score(["-5","-10","+","D","C","+"]), -55)
        self.assertEqual(ch_2.final_score(["3","6","+","D","C","8","+","D","-2","C","+"]), 128)


if __name__ == '__main__':
    unittest.main()
