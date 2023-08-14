#!/usr/bin/env python
# -*- coding: utf-8 -*-
from itertools import permutations
import unittest


def cute_list_count(n):
    list_ = list(range(1, n + 1))
    count = 0

    for perm in permutations(list_):
        if is_cute(perm):
            count += 1

    return count


def is_cute(list_):
    for i, val in enumerate(list_):
        if val % (i + 1) != 0 and (i + 1) % val != 0:
            return False
    return True


class TestCuteListCount(unittest.TestCase):
    def test_example(self):
        self.assertEqual(cute_list_count(2), 2)


if __name__ == '__main__':
    unittest.main()
