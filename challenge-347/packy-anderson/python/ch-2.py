#!/usr/bin/env python

import re

def format_phone2(phone, formatted):
  if len(phone) < 4:
    return formatted + phone
  elif len(phone) == 4:
    return formatted + phone[0:2] + "-" + phone[2:4]
  else:
    return format_phone2(
      phone[3:],
      formatted + phone[0:3] + "-" 
    )

def format_phone(phone):
  phone = re.sub(r'\D', '', phone)
  return format_phone2(phone, "")

def solution(phone):
  print(f'Input: $phone = "{phone}"')
  print(f'Output: "{format_phone(phone)}"')

print('Example 1:')
solution("1-23-45-6")

print('\nExample 2:')
solution("1234")

print('\nExample 3:')
solution("12 345-6789")

print('\nExample 4:')
solution("123 4567")

print('\nExample 5:')
solution("123 456-78")
