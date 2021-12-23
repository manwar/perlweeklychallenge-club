#!/usr/bin/python3

# Challenge 030
#
# Task #1
# Write a script to list dates for Sunday Christmas between 2019 and 2100. For
# example, 25 Dec 2022 is Sunday.

import datetime

sunday_xmas = []
for year in range(2019, 2101):
    dt = datetime.date(year, 12, 25)
    if dt.isoweekday()==7:
        sunday_xmas.append(year)
print(*sunday_xmas, sep=", ")
