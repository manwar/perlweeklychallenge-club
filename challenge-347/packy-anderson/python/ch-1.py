#!/usr/bin/env python

from datetime import date
import re

months = {
  'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4,  'May': 5,  'Jun': 6,
  'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
}

def format_date(dstr):
  day, month, year = dstr.split()

  m = re.match(r'(\d+)(\D+)', day)
  dnum = int(m.group(1)) # make sure it's an int
  dord = m.group(2)
  if not (
    ((dnum == 1 or dnum == 21 or dnum == 31) and dord == "st")
    or
    ((dnum == 2 or dnum == 22) and dord == "nd")
    or
    ((dnum == 3 or dnum == 23) and dord == "rd")
    or
    dord == "th"
  ):
    return f"{day} has the incorrect ordinal"
  day = dnum # grab just the numeric portion

  if not month in months:
    return f"Unknown month '{month}'"

  month = months[month] # convert to numeric

  year = int(year) # make sure it's an int
  if not (1900 <= year <= 2100):
    return "Year must be between 1900-2100"

  try:
    dateobj = date(year, month, day)
  except ValueError as err:
    return err

  return f'"#{dateobj.strftime("%Y-%m-%d")}"'

def solution(dstr):
  print(f'Input: $str = "{dstr}"')
  print(f'Output: {format_date(dstr)}')

print('Example 1:')
solution("1st Jan 2025")

print('\nExample 2:')
solution("22nd Feb 2025")

print('\nExample 3:')
solution("15th Apr 2025")

print('\nExample 4:')
solution("23rd Oct 2025")

print('\nExample 5:')
solution("31st Dec 2025")

print('\nExample Year Too Big:')
solution("31st Dec 2525")

print('\nExample Year Too Small:')
solution("31st Dec 1825")

print('\nExample Bad Ordinal:')
solution("31nd Dec 2025")

print('\nExample Bad Month:')
solution("30th Avril 2025")

print('\nExample Bad Date:')
solution("31st Feb 2025")
