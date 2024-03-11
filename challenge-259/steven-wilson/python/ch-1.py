#!/usr/bin/env python3

from datetime import timedelta
from datetime import date


def banking_day_offset(start_date, offset, bank_holidays=None):
    ''' Given a number (of days) and a start date, return the number (of days)
    adjusted to take into account non-banking days. In other words: convert a
    banking day offset to a calendar day offset.

    >>> banking_day_offset('2018-06-28', 3, ['2018-07-03'])
    '2018-07-04'
    >>> banking_day_offset('2018-06-28', 3)
    '2018-07-03'
    '''
    if bank_holidays is None:
        bank_holidays = []

    if not isinstance(offset, int) or offset < 0:
        raise ValueError(f"{offset} is not a valid offset")

    try:
        odate = date.fromisoformat(start_date)
    except ValueError:
        raise ValueError(f"{start_date} is not a valid iso format start date")

    for holiday in bank_holidays:
        try:
            date.fromisoformat(holiday)
        except ValueError:
            raise ValueError(f"{holiday} is not a valid iso format bank holiday")

    weekend = [5, 6]

    for _ in range(offset):
        odate += timedelta(days=1)
        while odate.weekday() in weekend or odate.isoformat() in bank_holidays:
            odate += timedelta(days=1)

    return odate.isoformat()


if __name__ == "__main__":
    import doctest

    doctest.testmod()
