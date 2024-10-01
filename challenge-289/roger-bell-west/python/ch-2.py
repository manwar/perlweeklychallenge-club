#! /usr/bin/python3

import fileinput
import re
import random

def jumble(a):
  b = list(a)
  random.shuffle(b)
  return "".join(b)

def replace(mt):
  return mt.group(1) + jumble(mt.group(2)) + mt.group(3)

wordre = re.compile(r"([A-Za-z])([A-Za-z][A-Za-z]+)([A-Za-z])")

for line in fileinput.input():
  line = line.rstrip()
  l = re.sub(wordre, replace, line)
  print(l)
