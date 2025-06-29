#!/usr/bin/env python3

from datetime import date
import re
import sys


def day_of_year(input_date: str) -> int:
    """
    Calculate the day of the year from a date string in 'YYYY-MM-DD' format.
    :param input_date: Date string in 'YYYY-MM-DD' format
    :return: Day of the year as an integer
    """

    # Validate the input date format
    if not re.match(r'^\d{4}-\d\d?-\d\d?$', input_date):
        raise ValueError("Input date must be in 'YYYY-MM-DD' format")

    year, month, day = map(int, input_date.split('-'))
    return int((date(year, month, day).strftime('%j')))


def main():
    result = day_of_year(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
