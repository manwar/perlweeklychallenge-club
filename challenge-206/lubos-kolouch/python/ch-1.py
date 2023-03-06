#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def shortest_time_in_minutes(*times):
    min_diff = 24 * 60  # maximum possible difference in minutes
    for i in range(len(times) - 1):
        for j in range(i + 1, len(times)):
            h1, m1 = map(int, times[i].split(':'))
            h2, m2 = map(int, times[j].split(':'))
            diff = abs((h1 - h2) * 60 + (m1 - m2))
            diff = 24 * 60 - diff if diff > 12 * 60 else diff  # account for circular time
            min_diff = min(diff, min_diff)
    return min_diff


class TestShortestTimeInMinutes(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(shortest_time_in_minutes("00:00", "23:55", "20:00"),
                         5)

    def test_example2(self):
        self.assertEqual(shortest_time_in_minutes("01:01", "00:50", "00:57"),
                         4)

    def test_example3(self):
        self.assertEqual(
            shortest_time_in_minutes("10:10", "09:30", "09:00", "09:55"), 15)


if __name__ == '__main__':
    unittest.main()
