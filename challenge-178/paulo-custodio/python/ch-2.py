#!/usr/bin/env python3

# Challenge 178
#
# Task 2: Business Date
# Submitted by: Mohammad S Anwar
#
# You are given $timestamp (date with time) and $duration in hours.
#
# Write a script to find the time that occurs $duration business hours after
# $timestamp. For the sake of this task, let us assume the working hours is 9am
# to 6pm, Monday to Friday. Please ignore timezone too.
#
# For example,
#
# Suppose the given timestamp is 2022-08-01 10:30 and the duration is 4 hours.
# Then the next business date would be 2022-08-01 14:30.
#
# Similar if the given timestamp is 2022-08-01 17:00 and the duration is 3.5 hours.
# Then the next business date would be 2022-08-02 11:30.

from datetime import datetime, timedelta
import sys

def next_business_date(date_text, time_text, hours):
    date_str = f"{date_text} {time_text}"
    date = datetime.strptime(date_str, "%Y-%m-%d %H:%M")

    minutes = hours * 60
    while True:
        end_day = date.replace(hour=18, minute=0)
        remain = (end_day - date).total_seconds() / 60
        if minutes < remain:
            date += timedelta(minutes=minutes)
            return date
        else:
            minutes -= remain
            date = end_day + timedelta(hours=(24 - 18) + 9)
            while date.weekday() >= 5:  # skip weekend
                date += timedelta(days=1)

if len(sys.argv) != 4:
    raise ValueError("usage: ch-2.py yyyy-mm-dd HH:MM hours")

result_date = next_business_date(sys.argv[1], sys.argv[2], float(sys.argv[3]))
print(result_date.strftime("%Y-%m-%d %H:%M"))
