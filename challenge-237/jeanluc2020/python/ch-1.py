#!/usr/bin/python3
# https://theweeklychallenge.org/blog/perl-weekly-challenge-237/#TASK1
#
# Task 1: Seize The Day
# =====================
#
# Given a year, a month, a weekday of month, and a day of week (1 (Mon) .. 7 (Sun)), print the day.
#
## Example 1
##
## Input: Year = 2024, Month = 4, Weekday of month = 3, day of week = 2
## Output: 16
##
## The 3rd Tue of Apr 2024 is the 16th
#
## Example 2
##
## Input: Year = 2025, Month = 10, Weekday of month = 2, day of week = 4
## Output: 9
##
## The 2nd Thu of Oct 2025 is the 9th
#
## Example 3
##
## Input: Year = 2026, Month = 8, Weekday of month = 5, day of week = 3
## Output: 0
##
## There isn't a 5th Wed in Aug 2026
#
############################################################
##
## discussion
##
############################################################
#
# This is a case for the datetime module:
# - First we calculate the day of week for the 1st of the given month by
#   creating a DateTime object
# - Then we calculate the first day of the month that matches our target
#   day of week
# - From that, we calculate the weekday of month's date by adding another
#   7 for each week we're out from the first week
# - If we went past the end of the month, we return 0, otherwise the
#   calculated date

from datetime import date
import calendar

def seize_the_day(year: int, month: int, weekday_of_month: int, day_of_week: int):
    print(f"Input: Year = {year}, month = {month}, weekday of month = {weekday_of_month}, day of week = {day_of_week}")
    if weekday_of_month < 1 or weekday_of_month > 5:
        print("Output: 0")
        return
    dtformat = "{year:4d}-{month:02d}-{day:02d}"
    dt = date.fromisoformat(dtformat.format(year = year, month = month, day = 1))
    days_per_month = { 1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31 }
    if calendar.isleap(year):
        days_per_month[2] = 29

    dow_1st = dt.isoweekday()
    first_appearance_of_dow = day_of_week - dow_1st +1
    if day_of_week < dow_1st:
        first_appearance_of_dow += 7
    nth_appearance_of_dow = first_appearance_of_dow + (weekday_of_month-1) * 7
    if nth_appearance_of_dow > days_per_month[month]:
        print("Output: 0")
        return
    print(f"Output: {nth_appearance_of_dow}")


seize_the_day(year = 2024, month = 4,  weekday_of_month = 3, day_of_week = 2);
seize_the_day(year = 2025, month = 10, weekday_of_month = 2, day_of_week = 4);
seize_the_day(year = 2026, month = 8,  weekday_of_month = 5, day_of_week = 3);


