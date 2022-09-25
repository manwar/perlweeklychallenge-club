#!/usr/bin/env python3

import sys
from datetime import date
from dateutil.relativedelta import relativedelta


def main(date1, date2):
    date1 = date.fromisoformat(date1)
    date2 = date.fromisoformat(date2)

    # Make date2 the latest date
    if date2 < date1:
        date2, date1 = date1, date2

    # Calculate the years between the two dates. If date2 is earlier in the
    #  year than date1, then the year difference is one less
    years = date2.year - date1.year
    if date2.month < date1.month or (date2.month == date1.month and date2.day < date1.day):
        years -= 1

    # Calculate the days difference
    days = (date2 - relativedelta(years=years) - date1).days

    # Print the output
    diff = []
    if years > 1:
        diff.append(f'{years} years')
    elif years == 1:
        diff.append(f'1 year')

    if days > 1:
        diff.append(f'{days} days')
    elif days == 1:
        diff.append(f'1 day')

    print(*diff, sep=' ')


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
