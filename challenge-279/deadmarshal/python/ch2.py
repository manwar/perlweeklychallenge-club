#!/usr/bin/env python

def split_string(s):
  vowels = 'aeiouAEIOU'
  return sum(s.count(v) for v in vowels) % 2 == 0

print(split_string('perl'))
print(split_string('book'))
print(split_string('good morning'))

