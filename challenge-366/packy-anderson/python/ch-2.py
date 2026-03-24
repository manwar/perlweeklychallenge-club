#!/usr/bin/env python

def possible(field, maxval):
  if field == "??": return maxval+1
  if field.find("?") == -1:
    return 1 if int(field) <= maxval else 0
  count = 0
  for i in range(0, 10):
    if int(field.replace("?", str(i))) > maxval: return count
    count += 1
  return count

def valid_times(time):
  hours, minutes = time.split(":")
  return possible(hours, 23) * possible(minutes, 59)

def solution(time):
  print(f'Input: $time = "{time}"')
  print(f'Output: {valid_times(time)}')

print('Example 1:')
solution("?2:34")

print('\nExample 2:')
solution("?4:?0")

print('\nExample 3:')
solution("??:??")

print('\nExample 4:')
solution("?3:45")

print('\nExample 5:')
solution("2?:15")

print('\nExample Trivial 1:')
solution("23:59")

print('\nExample Trivial 2:')
solution("25:1?")
