#!/usr/bin/env python3

import sys
from datetime import date, timedelta


def main(year, month, week, dofw):
    # Get the first of the month
    dte = date(year, month, 1)

    # Day of the week for the first of the month (1 - Monday, 7 - Sunday)
    first_weekday = dte.isoweekday()

    # To get the first day of week we take the diff between the two values. If
    #  it is negative, add 7 days
    add_days = dofw - first_weekday
    if add_days < 0:
        add_days += 7

    # Now add the weeks
    add_days += (week-1) * 7

    new_date = dte + timedelta(days=add_days)
    if new_date.month != dte.month or new_date.year != dte.year:
        # This date does not exist
        print(0)
    else:
        # Print the day of month
        print(new_date.day)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(*array)
