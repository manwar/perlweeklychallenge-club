#!/usr/bin/env python

from datetime import datetime, timedelta

def mytime(t):
  return datetime.strptime(f'2000-01-01T{t}', '%Y-%m-%dT%H:%M')

def convert_time(source, target):
  s = mytime(source)
  t = mytime(target)
  if t < s: # it must be a time in the next day
    t += timedelta(days = 1) # add 1 day
  diff = int((t - s).seconds / 60)
  ops = []
  for op in [60, 15, 5, 1]:
    n = diff // op
    if n:
      minutes = "minute" if op == 1 else "minutes"
      for i in range(n): ops.append(f'Add {op} {minutes}')
      diff -= n * op
      if diff == 0: break
  count = len(ops)
  operations = "Operation" if count == 1 else "Operations"
  return f'{count}\n\n{operations}:\n + {"\n + ".join(ops)}'

def solution(source, target):
  print(f'Input: $source = "{source}"')
  print(f'       $target = "{target}"')
  print(f'Output: {convert_time(source, target)}')


print('Example 1:')
solution("02:30", "02:45")

print('\nExample 2:')
solution("11:55", "12:15")

print('\nExample 3:')
solution("09:00", "13:00")

print('\nExample 4:')
solution("23:45", "00:30")

print('\nExample 5:')
solution("14:20", "15:25")
