#!/usr/bin/env python3

# TASK #1 > Long Year
# Submitted by: Mohammad S Anwar
# Write a script to find all the years between 1900 and 2100 which is a Long
# Year.
#
# A year is Long if it has 53 weeks.
#
#
# [UPDATED][2021-11-01 16:20:00]: For more information about Long Year, please
# refer to wikipedia.
#
# Expected Output
# 1903, 1908, 1914, 1920, 1925,
# 1931, 1936, 1942, 1948, 1953,
# 1959, 1964, 1970, 1976, 1981,
# 1987, 1992, 1998, 2004, 2009,
# 2015, 2020, 2026, 2032, 2037,
# 2043, 2048, 2054, 2060, 2065,
# 2071, 2076, 2082, 2088, 2093,
# 2099

# https://en.wikipedia.org/wiki/ISO_week_date#Weeks_per_year
# years in which 1 January or 31 December are Thursdays

import datetime

def is_long_year(year):
    dt = datetime.date(year, 1, 1)
    if dt.isoweekday()==4:
        return True
    dt = datetime.date(year, 12, 31)
    if dt.isoweekday()==4:
        return True
    return False

years = list(filter(lambda x:is_long_year(x), range(1900, 2100+1)))
for i in range(0, len(years), 5):
    out = ", ".join([str(x) for x in years[i:i+5]])
    if i+5 < len(years):
        out += ","
    print(out)
