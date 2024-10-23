#!/usr/bin/env python3

# Challenge 181
#
# Task 2: Hot Day
# Submitted by: Mohammad S Anwar
#
# You are given file with daily temperature record in random order.
#
# Write a script to find out days hotter than previous day.
# Example
#
# Input File: (temperature.txt)
#
# 2022-08-01, 20
# 2022-08-09, 10
# 2022-08-03, 19
# 2022-08-06, 24
# 2022-08-05, 22
# 2022-08-10, 28
# 2022-08-07, 20
# 2022-08-04, 18
# 2022-08-08, 21
# 2022-08-02, 25
#
# Output:
# 2022-08-02
# 2022-08-05
# 2022-08-06
# 2022-08-08
# 2022-08-10

import sys
from datetime import datetime, timedelta

def read_data(file):
    with open(file, "r") as f:
        temps = []
        for line in f:
            line = line.strip()
            if not line:
                continue
            parts = line.split(',')
            if len(parts) != 2:
                raise ValueError(f"cannot parse: {line}")
            date_parts = parts[0].strip().split('-')
            if len(date_parts) != 3:
                raise ValueError(f"cannot parse: {line}")
            year, month, day = map(int, date_parts)
            dt = datetime(year, month, day)
            temps.append((dt, int(parts[1].strip())))
    return temps

def print_temp_higher(temps):
    temps.sort(key=lambda x: x[0])
    for i in range(1, len(temps)):
        dt_diff = (temps[i][0] - temps[i-1][0]).days
        if temps[i][1] > temps[i-1][1] and dt_diff == 1:
            print(temps[i][0].strftime('%Y-%m-%d'))

if len(sys.argv) != 2:
    raise ValueError("usage: ch-2.py file")
print_temp_higher(read_data(sys.argv[1]))
