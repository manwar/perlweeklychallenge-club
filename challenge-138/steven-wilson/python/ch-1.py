#!/usr/bin/env python3

import sys
import datetime
import calendar

year = int(sys.argv[1])
day = datetime.datetime(year, 1, 1)
week_day = day.isoweekday()
is_leap_year = int(calendar.isleap(year))
workdays = {
    '10': 261,
    '11': 262,
    '20': 261,
    '21': 262,
    '30': 261,
    '31': 262,
    '40': 261,
    '41': 262,
    '50': 261,
    '51': 261,
    '60': 260,
    '61': 260,
    '70': 260,
    '71': 261,
}

print(workdays[str(week_day) + str(is_leap_year)])
