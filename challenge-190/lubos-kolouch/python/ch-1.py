#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def capital_detection(s):
    if s[0].isupper() and s[1:].islower():  # Rule 1
        return 1
    if s.islower():                         # Rule 2
        return 1
    if s.isupper():                         # Rule 3
        return 1
    return 0


class TestCapitalDetection(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(capital_detection('Perl'), 1)
        self.assertEqual(capital_detection('TPF'), 1)
        self.assertEqual(capital_detection('PyThon'), 0)
        self.assertEqual(capital_detection('raku'), 1)


if __name__ == '__main__':
    unittest.main()
