#!/usr/bin/env python3

# Challenge 048
#
# TASK #2
# Palindrome Dates
# Write a script to print all Palindrome Dates between 2000 and 2999. The format
# of date is mmddyyyy. For example, the first one was on October 2, 2001 as it is
# represented as 10022001.

from datetime import datetime, timedelta

dt = datetime(2000,1,1)
while dt < datetime(3000,1,1):
    str = dt.strftime("%m%d%Y")
    if str[::-1] == str:
        print(str)
    dt += timedelta(days=1)
