#!/usr/bin/env python3

# Challenge 038
#
# TASK #1
# Date Finder
# Create a script to accept a 7 digits number, where the first number can only
# be 1 or 2. The second and third digits can be anything 0-9. The fourth and
# fifth digits corresponds to the month i.e. 01,02,03...,11,12. And the last
# 2 digits respresents the days in the month i.e. 01,02,03...29,30,31. Your
# script should validate if the given number is valid as per the rule and then
# convert into human readable format date.
#
# RULES
# If 1st digit is 1, then prepend 20 otherwise 19 to the 2nd and 3rd digits to
# make it 4-digits year.
#
# The 4th and 5th digits together should be a valid month.
#
# The 6th and 7th digits together should be a valid day for the above month.
#
# For example, the given number is 2230120, it should print 1923-01-20.

from datetime import date
from calendar import monthrange
import re
import sys

input = sys.argv[1]
if not (m := re.match(r"^([12])(\d\d)([01]\d)([0-3]\d)$", input)):
    print("malformed input")
else:
    year_msb = int(m.group(1))
    year_lsb = int(m.group(2))
    month = int(m.group(3))
    day = int(m.group(4))

    if year_msb == 1:
        year = 2000+year_lsb
    else:
        year = 1900+year_lsb

    if not 1 <= month <= 12:
        print("malformed month")
    else:
        if not 1 <= day <= monthrange(year, month)[1]:
            print("malformed day")
        else:
            dt = date(year=year, month=month, day=day)
            print(dt.strftime("%Y-%m-%d"))
