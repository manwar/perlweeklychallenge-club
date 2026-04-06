#!/usr/bin/env python3

# Perl Weekly Challenge 183 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-183/

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
