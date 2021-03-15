#!/usr/bin/env python

# Challenge 100
# 
# TASK #1 > Fun Time
# Submitted by: Mohammad S Anwar
# You are given a time (12 hour / 24 hour).
#
# Write a script to convert the given time from 12 hour format to 24 hour format
# and vice versa.
#
# Ideally we expect a one-liner.
#
# Example 1:
# Input: 05:15 pm or 05:15pm
# Output: 17:15
# Example 2:
# Input: 19:15
# Output: 07:15 pm or 07:15pm

import re;
import sys;
import datetime;

if re.search(r'am|pm', sys.argv[1], re.I):
    t = datetime.datetime.strptime(sys.argv[1], "%I:%M%p")
    print(t.strftime("%H:%M"))
else:
    t = datetime.datetime.strptime(sys.argv[1], "%H:%M")
    print(t.strftime("%I:%M%p").lower())
