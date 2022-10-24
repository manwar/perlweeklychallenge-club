"""Perl weekly challenge 187 - Task 1: Days Together.

Two friends, Foo and Bar gone on holidays seperately to the same city.
You are given their schedule i.e. 'start date' and 'end date'.
To keep the task simple, the date is in the form 'DD-MM' and all dates
belong to the same calendar year i.e. between '01-01' and '31-12'. Also
the year is 'non-leap year'. Also both dates are inclusive.
Write a script to find out for the given schedule, how many days they
spent together in the city, if at all.

https://theweeklychallenge.org/blog/perl-weekly-challenge-187/
"""
import datetime
import unittest

NONE_LEAP_YEAR = 2022


def to_day_of_year(day_mon: str, year: int = NONE_LEAP_YEAR) -> int:
    """Convert a "DD-MM" date string to the day of the year.

    All dates belong to the same calendar year, and it isn't a "leap year".

    :param day_mon: date in "DD-MM" format
    :param year: year. default is a non-leap year
    :return: day of the year
    """
    date = datetime.date(year, int(day_mon[3:]), int(day_mon[0:2]))
    return int(f"{date:%j}")


def days_together(foo: dict, bar: dict) -> int:
    """Find how many days are spent together for the given schedules.

    :param foo: schedule of 1st person
    :param bar:schedule of 2nd person
    :return: number of pent together days
    """
    foo_sd, foo_ed = to_day_of_year(foo['SD']), to_day_of_year(foo['ED'])
    bar_sd, bar_ed = to_day_of_year(bar['SD']), to_day_of_year(bar['ED'])
    if foo_sd > bar_ed or foo_ed < bar_sd:
        return 0
    return min(foo_ed, bar_ed) - max(foo_sd, bar_sd) + 1


class TestDaysTogether(unittest.TestCase):

    def test_days_together(self):
        cases = (
            {'args': ({'SD': '12-01', 'ED': '20-01'}, {'SD': '15-01', 'ED': '18-01'}), 'expected': 4},
            {'args': ({'SD': '02-03', 'ED': '12-03'}, {'SD': '13-03', 'ED': '14-03'}), 'expected': 0},
            {'args': ({'SD': '02-03', 'ED': '12-03'}, {'SD': '11-03', 'ED': '15-03'}), 'expected': 2},
            {'args': ({'SD': '30-03', 'ED': '05-04'}, {'SD': '28-03', 'ED': '02-04'}), 'expected': 4},
        )
        for case in cases:
            self.assertEqual(days_together(*case['args']), case['expected'], str(case['args']))


if __name__ == '__main__':
    unittest.main()
