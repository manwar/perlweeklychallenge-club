#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(ch_1.longest_repeating_char("AAAAA", 2), 5)
        self.assertEqual(ch_1.longest_repeating_char("ABCDE", 4), 5)
        self.assertEqual(ch_1.longest_repeating_char("AAABBBBAA", 1), 5)
        self.assertEqual(ch_1.longest_repeating_char("ABACADA", 2), 5)
        self.assertEqual(ch_1.longest_repeating_char("BAAABAAAA", 1), 8)

    def test_ch_2(self):
        path_1 = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"
        path_2 = "file1.txt\nfile2.ext\na.png"
        path_3 = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
        path_4 = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"
        path_5 = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"

        self.assertEqual(ch_2.longest_absolute_path(path_1), 0)
        self.assertEqual(ch_2.longest_absolute_path(path_2), 9)
        self.assertEqual(ch_2.longest_absolute_path(path_3), 38)
        self.assertEqual(ch_2.longest_absolute_path(path_4), 14)
        self.assertEqual(ch_2.longest_absolute_path(path_5), 32)


if __name__ == "__main__":
    unittest.main()
