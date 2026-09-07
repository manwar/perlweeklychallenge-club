#!/usr/bin/env python

import math
import re
pat = re.compile(r'(\d*)\.(\d*)?(?:\((\d*)\))?')

def rational_to_fraction(rat):
  int_v, nr_v, rep_v = pat.match(rat).group(1,2,3)
  if not nr_v:  nr_v = 0  # if no non-repeating digits, use 0
  if not rep_v: rep_v = 0 # if no repeating digits, use 0
  pow1  = 10 ** len(nr_v)      if nr_v  else 1
  pow2  = 10 ** len(rep_v) - 1 if rep_v else 1
  int_v = int(int_v) # convert strings to integers
  nr_v  = int(nr_v)
  rep_v = int(rep_v)
  num   = (int_v * pow1 + nr_v) * pow2 + rep_v
  denom = pow2 * pow1
  d     = math.gcd(num, denom)
  return (num // d, denom // d)

def rational_equal(rat1, rat2):
  n1, d1 = rational_to_fraction(rat1)
  n2, d2 = rational_to_fraction(rat2)
  l = max(len(rat1), len(rat2))
  return (
    'true' if n1 == n2 and d1 == d2 else 'false',
    f"{rat1:>{l}} is {n1}/{d1}\n{rat2:>{l}} is {n2}/{d2}"
  )

def solution(rat1, rat2):
  print(f'Input: $rat1 = "{rat1}"')
  print(f'       $rat2 = "{rat2}"')
  output, explain = rational_equal(rat1, rat2)
  print(f'Output: {output}\n\n{explain}')

print('Example 1:')
solution("0.(12)", "0.(121)")

print('\nExample 2:')
solution("0.1(23)", "0.12(32)")

print('\nExample 3:')
solution("0.1(234)", "0.12(342)")

print('\nExample 4:')
solution("12.99(99)", "13.")

print('\nExample 5:')
solution("0.(123)", "0.1(231)")
