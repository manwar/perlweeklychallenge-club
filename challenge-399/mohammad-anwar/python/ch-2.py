#!/usr/bin/env python3

import unittest

class TestLongestAbsolutePath(unittest.TestCase):
    def test_examples(self):
        examples = [
            {
                "in": "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2",
                "out": 0
            },
            {
                "in": "file1.txt\nfile2.ext\na.png",
                "out": 9
            },
            {
                "in": "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png",
                "out": 38
            },
            {
                "in": "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt",
                "out": 14
            },
            {
                "in": "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt",
                "out": 32
            },
        ]

        for ex in examples:
            with self.subTest(in_val=ex["in"]):
                self.assertEqual(longest_absolute_path(ex["in"]), ex["out"])

def longest_absolute_path(fs):
    lens = {}
    max_len = 0

    for line in fs.split('\n'):
        depth = line.count('\t')
        name = line[depth:]
        len_path = (lens.get(depth - 1) + 1 if depth > 0 else 0) + len(name)

        lens[depth] = len_path
        if '.' in name and len_path > max_len:
            max_len = len_path

    return max_len

if __name__ == '__main__':
    unittest.main()
