#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        result_3 = ["UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD"]
        result_5 = ["UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD",
            "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD",
            "UUDUUDDD", "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD"
        ]

        self.assertEqual(ch_1.dyck_words(1), ["UD"])
        self.assertEqual(ch_1.dyck_words(2), ["UDUD","UUDD"])
        self.assertEqual(ch_1.dyck_words(3), result_3)
        self.assertEqual(ch_1.dyck_words(0), [])
        self.assertEqual(ch_1.dyck_words(4), result_5)

    def test_ch_2(self):
        self.assertEqual(ch_2.secret_santa(1), 0)
        self.assertEqual(ch_2.secret_santa(2), 1)
        self.assertEqual(ch_2.secret_santa(3), 2)
        self.assertEqual(ch_2.secret_santa(4), 9)
        self.assertEqual(ch_2.secret_santa(5), 44)


if __name__ == "__main__":
    unittest.main()
