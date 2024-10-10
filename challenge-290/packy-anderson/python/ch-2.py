#!/usr/bin/env python

def luhnCheck(num):
  # just the numeric digits of the number
  digits = [ d for d in num if d.isnumeric() ]
  # the last digit is the payload/checksum
  payload = digits.pop()

  to_be_summed = ''
  multiplier = 2 # we'll alternate between 2 & 1

  digits.reverse() # reverse the digits
  # pull the last digit off the number
  for digit in digits:
    to_be_summed += str(int(digit) * multiplier)
    # alternate the multiplier
    multiplier = 1 if multiplier == 2 else 2

  # add up the digits
  digitSum = sum([ int(d) for d in to_be_summed ])
  # add the payload back in
  digitSum += int(payload)
  # is it a multiple of 10
  return digitSum % 10 == 0

def solution(num):
  print(f'Input: "{num}"')
  print(f'Output: {luhnCheck(num)}')

print('Example 1:')
solution("17893729974")

print('\nExample 2:')
solution("4137 8947 1175 5904")

print('\nExample 3:')
solution("4137 8974 1175 5904")
