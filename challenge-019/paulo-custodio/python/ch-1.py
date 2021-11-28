#!/usr/bin/python3

# Challenge 019
#
# Task #1
# Write a script to display months from the year 1900 to 2019 where you find
# 5 weekends i.e. 5 Friday, 5 Saturday and 5 Sunday.
#
# Solution: 4 weeks are 28 days, to have 5 week-ends we need additional 3 days
# (29,30,31),
# therefore 31st must be a Sunday

import datetime

def five_weekends(year, month):
    return month in [1,3,5,7,8,10,12] and \
           datetime.date(year, month, 31).isoweekday() == 7

for year in range(1900, 2020):
    for month in range(1, 13):
        if five_weekends(year, month):
            print("{:04d}-{:02d}".format(year, month))
