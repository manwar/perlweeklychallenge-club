#!/usr/bin/env python3

from itertools import chain

def separate_digits(arr):
  return list(int(y) for y in chain.from_iterable([str(x) for x in arr]))

print(separate_digits([1,34,5,6]))
print(separate_digits([1,24,51,60]))

