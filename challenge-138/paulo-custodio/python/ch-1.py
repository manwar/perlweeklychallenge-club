#!/usr/bin/env python3

# TASK #1 > Workdays
# Submitted by: Mohammad S Anwar
# You are given a year, $year in 4-digits form.
#
# Write a script to calculate the total number of workdays in the given year.
#
# For the task, we consider, Monday - Friday as workdays.
#
# Example 1
# Input: $year = 2021
# Output: 261
# Example 2
# Input: $year = 2020
# Output: 262

import sys
import datetime

def count_work_days(year):
    count = 0
    dt = datetime.date(year, 1, 1)
    while dt.year == year:
        dow = dt.isoweekday()
        if dow < 6:
            count += 1
        dt += datetime.timedelta(days=1)
    return count

print(count_work_days(int(sys.argv[1])))
