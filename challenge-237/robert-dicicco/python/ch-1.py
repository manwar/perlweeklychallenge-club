#!/usr/bin/env python
'''
------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-02
Challenge 237 Task 01 Seize the Day ( Python )
-----------------------------------------
'''
import datetime
import calendar
import sys

year = sys.argv[1]
day_of_week = sys.argv[4]
month = sys.argv[2]
weekday_of_month = sys.argv[3]

cnt = 1
fnd = 0
print(f"Input: Year = {year}, Month = {month}, Weekday of month = {weekday_of_month}, day of week = {day_of_week}")
days_in_month = (calendar.monthrange(int(year), int(month))[1])
d = 1
while d <= days_in_month:
    dow = datetime.date(int(year),int(month),d).weekday()
    idw = int(day_of_week) - 1      # adjust for python Sun = 0, Mon = 1, etc
    if int(dow) == idw:
        if cnt == int(weekday_of_month):
            print(f"Output: {d}")
            fnd += 1
            break
        cnt += 1
    d += 1
if fnd == 0:
    print("Output: 0")

'''
------------------------------------------
SAMPLE OUTPUT
python .\SeizeDay.py 2024 4 3 2

Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
Output: 16

python .\SeizeDay.py 2025 10 2 4

Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
Output: 9

python .\SeizeDay.py 2026 8 5 3
Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
Output: 0
-----------------------------------------
'''



