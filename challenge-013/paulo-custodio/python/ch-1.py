#!/usr/bin/python3

# Challenge 013
#
# Challenge #1
# Write a script to print the date of last Friday of every month of a given year.
# For example, if the given year is 2019 then it should print the following:
#
# 2019/01/25
# 2019/02/22
# 2019/03/29
# 2019/04/26
# 2019/05/31
# 2019/06/28
# 2019/07/26
# 2019/08/30
# 2019/09/27
# 2019/10/25
# 2019/11/29
# 2019/12/27

import sys
import datetime

def last_day_of_month(year, month):
    dt = datetime.date(year, month, 28)
    while dt.month==month:
        dt += datetime.timedelta(days=1)
    dt -= datetime.timedelta(days=1)
    return dt

def last_friday(dt):
    while dt.isoweekday()!=5:
        dt -= datetime.timedelta(days=1)
    return dt

def print_last_fridays(year):
    for month in range(1, 13):
        dt = last_friday(last_day_of_month(year, month))
        print(dt.strftime("%Y/%m/%d"))

print_last_fridays(int(sys.argv[1]))
