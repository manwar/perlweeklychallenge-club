#!/usr/bin/env python3

# Challenge 175
#
# Task 1: Last Sunday
# Submitted by: Mohammad S Anwar
#
# Write a script to list Last Sunday of every month in the given year.
#
# For example, for year 2022, we should get the following:
#
# 2022-01-30
# 2022-02-27
# 2022-03-27
# 2022-04-24
# 2022-05-29
# 2022-06-26
# 2022-07-31
# 2022-08-28
# 2022-09-25
# 2022-10-30
# 2022-11-27
# 2022-12-25

from datetime import datetime, timedelta
import sys

def last_sunday_month(year, month):
    last_day = (datetime(year, month + 1, 1) - timedelta(days=1)) if month < 12 else datetime(year + 1, 1, 1) - timedelta(days=1)
    while last_day.weekday() != 6:  # 6 is Sunday
        last_day -= timedelta(days=1)
    return last_day

def last_sunday_year(year):
    return [last_sunday_month(year, month) for month in range(1, 13)]

if len(sys.argv) != 2:
    raise ValueError("usage: ch-1.py year")
year = int(sys.argv[1])
for date in last_sunday_year(year):
    print(date.strftime('%Y-%m-%d'))
