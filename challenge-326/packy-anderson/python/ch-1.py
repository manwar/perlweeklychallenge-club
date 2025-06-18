#!/usr/bin/env python

from datetime import date
def solution(dateStr):
  print(f'Input: $date = \'{dateStr}\'')
  day_of_year = int(date.fromisoformat(dateStr).strftime('%j'))
  print(f'Output: {day_of_year}')


print('Example 1:')
solution('2025-02-02')

print('\nExample 2:')
solution('2025-04-10')

print('\nExample 3:')
solution('2025-09-07')
