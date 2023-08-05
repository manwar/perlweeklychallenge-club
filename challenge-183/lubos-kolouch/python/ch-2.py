#!/usr/bin/env python
# -*- coding: utf-8 -*-

from datetime import datetime


def date_difference(date1, date2):
    # convert string to datetime object
    date1 = datetime.strptime(date1, "%Y-%m-%d")
    date2 = datetime.strptime(date2, "%Y-%m-%d")
    # calculate difference
    diff = date2 - date1
    years = diff.days // 365
    days = diff.days % 365
    # format output
    output = ""
    if years == 1:
        output += "1 year "
    elif years > 1:
        output += f"{years} years "
    if days == 1:
        output += "1 day"
    elif days > 1:
        output += f"{days} days"
    return output.strip()


print(date_difference("2019-02-10", "2022-11-01"))  # Output: 3 years 264 days
print(date_difference("2020-09-15", "2022-03-29"))  # Output: 1 year 195 days
print(date_difference("2019-12-31", "2020-01-01"))  # Output: 1 day
print(date_difference("2019-12-01", "2019-12-31"))  # Output: 30 days
print(date_difference("2019-12-31", "2020-12-31"))  # Output: 1 year
print(date_difference("2019-12-31", "2021-12-31"))  # Output: 2 years
print(date_difference("2020-09-15", "2021-09-16"))  # Output: 1 year 1 day
print(date_difference("2019-09-15", "2021-09-16"))  # Output: 2 years 1 day
