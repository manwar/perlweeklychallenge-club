#!/usr/bin/env python
# -*- coding: utf-8 -*-

from datetime import datetime


def days_together(foo_start, foo_end, bar_start, bar_end):
    # Convert strings to datetime objects
    foo_start_date = datetime.strptime(foo_start, "%d-%m")
    foo_end_date = datetime.strptime(foo_end, "%d-%m")
    bar_start_date = datetime.strptime(bar_start, "%d-%m")
    bar_end_date = datetime.strptime(bar_end, "%d-%m")

    # Calculate the overlapping dates
    start = max(foo_start_date, bar_start_date)
    end = min(foo_end_date, bar_end_date)

    # Calculate the number of overlapping days
    overlapping_days = (end - start).days + 1

    return max(0, overlapping_days)  # Return 0 if dates do not overlap


print(days_together("12-01", "20-01", "15-01", "18-01"))  # Output: 4
print(days_together("02-03", "12-03", "13-03", "14-03"))  # Output: 0
print(days_together("02-03", "12-03", "11-03", "15-03"))  # Output: 2
print(days_together("30-03", "05-04", "28-03", "02-04"))  # Output: 4
