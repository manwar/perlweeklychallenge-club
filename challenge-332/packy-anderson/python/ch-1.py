#!/usr/bin/env python

def binary_date(date):
  return '-'.join([ bin(int(i))[2:] for i in date.split('-')])

def solution(date):
  print(f'Input: $date = "{date}"')
  print(f'Output: "{binary_date(date)}"')

print('Example 1:')
solution("2025-07-26")

print('\nExample 2:')
solution("2000-02-02")

print('\nExample 3:')
solution("2024-12-31")
