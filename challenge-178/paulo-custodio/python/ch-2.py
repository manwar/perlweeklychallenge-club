#!/usr/bin/env python3

# Perl Weekly Challenge 178 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-178/

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
