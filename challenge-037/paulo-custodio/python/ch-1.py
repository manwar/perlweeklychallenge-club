#!/usr/bin/env python3

# Challenge 037
#
# TASK #1
# Write a script to calculate the total number of weekdays (Mon-Fri) in each
# month of the year 2019.
# Jan: 23 days
# Feb: 20 days
# Mar: 21 days
# Apr: 22 days
# May: 23 days
# Jun: 20 days
# Jul: 23 days
# Aug: 22 days
# Sep: 21 days
# Oct: 23 days
# Nov: 21 days
# Dec: 22 days

from datetime import date, timedelta

months = {1:'Jan', 2:'Feb', 3:'Mar', 4:'Apr', 5:'May', 6:'Jun',
          7:'Jul', 8:'Aug', 9:'Sep', 10:'Oct', 11:'Nov', 12:'Dec'}

def month_work_days(year, month):
    work_days = 0
    dt = date(year=year, month=month, day=1)
    while dt.month == month:
        if dt.weekday() < 5:
            work_days += 1
        dt += timedelta(days=1)
    return work_days

def say_work_days(year):
    for month in range(1, 13):
        print(months[month]+": "+ \
              str(month_work_days(year, month))+ \
              " days")

say_work_days(2019)
