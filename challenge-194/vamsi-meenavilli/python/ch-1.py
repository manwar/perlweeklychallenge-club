import re
import unittest

"""
 Week 194:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-194

    Task 1: Digital Clock
    Submitted by: Mohammad S Anwar
    You are given time in the format hh:mm with one missing digit.
    
    Write a script to find the highest digit between 0-9 that makes it valid time.
"""


class DigitalClock:
    @staticmethod
    def digital_clock(time: str) -> int:
        missing_character_index = re.search("\\?", time).start()
        time = re.sub("\\?", "9", time)

        if missing_character_index < 3:
            hours = list(map(int, time.split(":")[0]))

            while int(''.join(map(str, hours))) > 23:
                hours[missing_character_index] -= 1

            return hours[missing_character_index]
        else:
            missing_character_index -= 3
            minutes = list(map(int, time.split(":")[1]))

            while int(''.join(map(str, minutes))) > 59:
                minutes[missing_character_index] -= 1

            return minutes[missing_character_index]


class DigitalClockTestCases(unittest.TestCase):
    def test_digital_clock(self):
        self.assertEqual(1, DigitalClock.digital_clock("?5:00"), 'Test case 1 Failed.')
        self.assertEqual(2, DigitalClock.digital_clock("?3:00"), 'Test case 2 Failed.')
        self.assertEqual(9, DigitalClock.digital_clock("1?:00"), 'Test case 3 Failed.')
        self.assertEqual(3, DigitalClock.digital_clock("2?:00"), 'Test case 4 Failed.')
        self.assertEqual(5, DigitalClock.digital_clock("12:?5"), 'Test case 5 Failed.')
        self.assertEqual(9, DigitalClock.digital_clock("12:5?"), 'Test case 6 Failed.')


if __name__ == '__main__':
    unittest.main()
