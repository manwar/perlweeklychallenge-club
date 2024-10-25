#!/usr/bin/env python3

# Challenge 183
#
# Task 2: Date Difference
# Submitted by: Mohammad S Anwar
#
# You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.
#
# Write a script to find the difference between the given dates in terms on years
# and days only.
# Example 1
#
# Input: $date1 = '2019-02-10'
#        $date2 = '2022-11-01'
# Output: 3 years 264 days
#
# Example 2
#
# Input: $date1 = '2020-09-15'
#        $date2 = '2022-03-29'
# Output: 1 year 195 days
#
# Example 3
#
# Input: $date1 = '2019-12-31'
#        $date2 = '2020-01-01'
# Output: 1 day
#
# Example 4
#
# Input: $date1 = '2019-12-01'
#        $date2 = '2019-12-31'
# Output: 30 days
#
# Example 5
#
# Input: $date1 = '2019-12-31'
#        $date2 = '2020-12-31'
# Output: 1 year
#
# Example 6
#
# Input: $date1 = '2019-12-31'
#        $date2 = '2021-12-31'
# Output: 2 years
#
# Example 7
#
# Input: $date1 = '2020-09-15'
#        $date2 = '2021-09-16'
# Output: 1 year 1 day
#
# Example 8
#
# Input: $date1 = '2019-09-15'
#        $date2 = '2021-09-16'
# Output: 2 years 1 day

from datetime import datetime
from dateutil.relativedelta import relativedelta
import sys

def date_diff(dt1, dt2):
    diff = relativedelta(dt2, dt1)
    years = diff.years
    result = "" if years == 0 else "1 year " if years == 1 else f"{years} years "
    dt1 += relativedelta(years=years)
    days = (dt2 - dt1).days
    result += "" if days == 0 else "1 day" if days == 1 else f"{days} days"
    return result

if len(sys.argv) != 3:
    raise ValueError("usage: script.py yyyy-mm-dd yyyy-mm-dd")

strp = "%Y-%m-%d"
dt = [datetime.strptime(arg, strp) for arg in sys.argv[1:]]
print(date_diff(*dt))
