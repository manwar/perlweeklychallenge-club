#!/usr/bin/env python

def conflict(event1, event2):
  end   = int(event1[1].replace(":", ""))
  start = int(event2[0].replace(":", ""))
  return end > start

def quote_wrap(array):
  return ', '.join([ f'"{t}"' for t in array ])

def solution(event1, event2):
  print(f'Input: @event1 = ({quote_wrap(event1)})')
  print(f'       @event2 = ({quote_wrap(event2)})')
  print(f'Output: {conflict(event1, event2)}')

print('Example 1:')
solution(["10:00", "12:00"], ["11:00", "13:00"])

print('\nExample 2:')
solution(["09:00", "10:30"], ["10:30", "12:00"])

print('\nExample 3:')
solution(["14:00", "15:30"], ["14:30", "16:00"])

print('\nExample 4:')
solution(["08:00", "09:00"], ["09:01", "10:00"])

print('\nExample 5:')
solution(["23:30", "00:30"], ["00:00", "01:00"])
