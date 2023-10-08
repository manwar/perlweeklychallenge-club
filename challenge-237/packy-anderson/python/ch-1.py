#!/usr/bin/env python

from datetime  import date, timedelta
from num2words import num2words

def seizeTheDay(year, month, weekday_of_month, day_of_week):
    """
    Function to determine, given a year, month, weekday of
    month and day of week, whether such a date exists and,
    if so, what day of the month it is.
    """
    # object for the first day of the specified month
    t = date(year, month, 1)

    # datetime.date.isoweekday returns 1 = Mon, 2 = Tue, etc.,
    # which matches our input, so no adjustment is needed

    # find the FIRST instance of the desired day of the week
    while ( t.isoweekday() != day_of_week ):
        t += timedelta(days = 1) # add 1 day

    # take note of some values that won't change
    # for our description
    month_name = t.strftime('%b')
    dow        = t.strftime('%a')
    count      = 1
  
    ord_weekday_of_month = num2words(
        weekday_of_month, to="ordinal_num"
    )

    # now roll forward through the month until the desired
    # weekday of the month
    while (
      # we're still in the desired month
      t.month == month
      and
      # we haven't reached the desired weekday of the month
      count < weekday_of_month
    ):
        # add a week to the date
        t += timedelta(days = 7)
        # add to the weekday of the month count
        count += 1

    # if we rolled out of the month, return an error condition
    if (t.month != month):
        return(
          0,
          f"There isn't a {ord_weekday_of_month} {dow} " +
          f"in {month_name} {year}"
        )
    else:
        # take note of what the day of the month is
        day = t.day
        ord_day_of_month = num2words(day, to="ordinal_num")
        return(
            day,
            f"The {ord_weekday_of_month} {dow} " +
            f"of {month_name} {year} is the {ord_day_of_month}"
        )

def solution(year, month, weekday_of_month, day_of_week):
    print(
        f'Input: Year = {year}, ' +
        f'Month = {month}, ' +
        f'Weekday of month = {weekday_of_month}, ' +
        f'day of week = {day_of_week}'
    )
    day, desc = seizeTheDay(
       year, month, weekday_of_month, day_of_week
    )
    print(f'Output: {day}\n\n{desc}')


print('Example 1:')
solution(
    year             = 2024, 
    month            = 4, 
    weekday_of_month = 3, 
    day_of_week      = 2
)

print('\nExample 2:')
solution(
    year             = 2025, 
    month            = 10, 
    weekday_of_month = 2, 
    day_of_week      = 4
)

print('\nExample 3:')
solution(
  year             = 2026, 
  month            = 8,
  weekday_of_month = 5, 
  day_of_week      = 3
)
