#!/usr/bin/env python
# -*- coding: utf-8 -*-

from datetime import datetime


def date_finder(input_str):
    if len(input_str) != 7:
        raise ValueError("Input must be 7 digits long")

    century_digit = input_str[0]
    year_digits = input_str[1:3]
    month_digits = input_str[3:5]
    day_digits = input_str[5:7]

    century = "20" if century_digit == "1" else "19"
    year = f"{century}{year_digits}"

    if int(month_digits) < 1 or int(month_digits) > 12:
        raise ValueError("Invalid month")

    try:
        datetime.strptime(f"{year}-{month_digits}-{day_digits}", "%Y-%m-%d")
    except ValueError:
        raise ValueError("Invalid day")

    return f"{year}-{month_digits}-{day_digits}"


print(date_finder("2230120"))  # 1923-01-20
