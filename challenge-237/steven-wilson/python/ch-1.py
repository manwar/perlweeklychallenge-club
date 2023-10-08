#!/usr/bin/env python3

from datetime import date, timedelta


def seize_the_day(year, month, week, dow):
    """ Given a year, a month, a week of month, and a day of week 
    (1 (Mon) .. 7 (Sun)), return the day of month, 0 is returned if not 
    possible
    >>> seize_the_day(2024, 4, 3, 2)
    16
    >>> seize_the_day(2025, 10, 2, 4)
    9
    >>> seize_the_day(2026, 8, 5, 3)
    0
    """
    d = date(year, month, (1 + (week - 1) * 7))
    while(d.isoweekday() != dow):
        d = d + timedelta(days=1)
    if(d.month == month):
        return d.day
    else:
        return 0


if __name__ == "__main__":
    import doctest

    doctest.testmod()
