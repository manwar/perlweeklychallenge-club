#!/usr/bin/env python3

# Perl Weekly Challenge 175 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-175/

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
