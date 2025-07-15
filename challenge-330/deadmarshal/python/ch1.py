#!/usr/bin/env python

import re

def clear_digits(s):
  p = r'\D\d'
  while re.search(p,s):
    s = re.sub(p,'',s)
  return s

print(clear_digits('cab12'))
print(clear_digits('xy99'))
print(clear_digits('pa1erl'))

