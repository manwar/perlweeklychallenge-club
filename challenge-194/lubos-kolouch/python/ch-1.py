#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def find_highest_digit(time: str) -> int:
    hour, minute = time.split(':')

    # Handle the hour part
    if hour[0] == '?':
        units_digit = int(hour[1])
        if units_digit <= 3:
            return 2
        else:
            return 1
    if hour[1] == '?':
        return 9 if hour[0] == '1' else 3

    # Handle the minute part
    if minute[0] == '?':
        return 5
    if minute[1] == '?':
        return 9

    return -1  # Should never reach here


class TestFindHighestDigit(unittest.TestCase):
    def test_example_1(self):
        self.assertEqual(find_highest_digit('?5:00'), 1,
                         "Tens place missing in hour, units digit 5")

    def test_example_2(self):
        self.assertEqual(find_highest_digit('?3:00'), 2,
                         "Tens place missing in hour, units digit 3")

    def test_example_3(self):
        self.assertEqual(find_highest_digit('1?:00'), 9,
                         "Units place missing in hour, tens digit 1")

    def test_example_4(self):
        self.assertEqual(find_highest_digit('2?:00'), 3,
                         "Units place missing in hour, tens digit 2")

    def test_example_5(self):
        self.assertEqual(find_highest_digit('12:?5'), 5,
                         "Tens place missing in minute")

    def test_example_6(self):
        self.assertEqual(find_highest_digit('12:5?'), 9,
                         "Units place missing in minute")


if __name__ == '__main__':
    unittest.main()
