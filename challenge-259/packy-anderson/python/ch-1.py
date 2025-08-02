#!/usr/bin/env python

from datetime import date, timedelta

def bankingDayOffset(start, offset, holidays):
  d = date.fromisoformat(start) # convert string to Date
  cnt = 0

  # convert holidays to Date objects
  holidays = [ date.fromisoformat(h) for h in holidays ]

  explain = []
  this_day = d.strftime('%A')
  while offset:
    d += timedelta(days = 1) # add 1 day
    next_day = d.strftime('%A')
    if (
      d.isoweekday() == 6 or # it's a Saturday
      d.isoweekday() == 7    # it's a Sunday
    ): 
      explain.append(
        f"{next_day} skipped because it's a weekend"
      )
    elif any([d == h for h in holidays]): # it's a Holiday
      explain.append(
        f"{next_day} skipped because it's a holiday"
      )
    else:
      offset -= 1
      cnt += 1
      explain.append(
        f"{next_day} bumped to {next_day} (offset {cnt})"
      )
      this_day = next_day
  return d.strftime('%F'), "\n".join(explain)

def solution(start, offset, holidays):
  holiday_display = ''
  if holidays:
    holiday_display = (
      "\n       $bank_holidays = ['" +
      "', '".join(holidays) + "']"
    )
  print(f"Input: $start_date = '{start}', $offset = {offset}{holiday_display}")
  output, explain = bankingDayOffset(start, offset, holidays)
  print(f"Output: '{output}'")
  print(f"\n{explain}")

print('Example 1:')
solution('2018-06-28', 3, ['2018-07-03'])

print('\nExample 2:')
solution('2018-06-28', 3, [])

print('\nExample 3:')
solution('2023-12-29', 5, ['2024-01-01'])
