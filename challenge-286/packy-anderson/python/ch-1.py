#!/usr/bin/env python

from random import randrange

words = []
with open(__file__) as fh:
  words.extend(fh.read().split())

print(f'{ words[ randrange( len(words) ) ] }')