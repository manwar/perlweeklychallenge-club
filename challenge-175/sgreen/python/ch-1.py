#!/usr/bin/env python3

import sys
from datetime import date, timedelta
from dateutil.relativedelta import relativedelta


def main(arg):
    # Use the year provided or the current year if it wasn't
    year = int(arg[0]) if len(arg) else date.today().year

    for m in range(12):
        # Get the last day of each month
        dt = date(year, 1+m, 1) + relativedelta(months=1) - timedelta(days=1)

        # Get the day of week (Monday is 1, Sunday is 7)
        dow = dt.isoweekday()

        # Take off the number of days to get last Sunday
        last_sunday = dt-timedelta(days=dow % 7)
        print(last_sunday.isoformat())


if __name__ == '__main__':
    main(sys.argv[1:])
