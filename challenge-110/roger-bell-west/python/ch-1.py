#! /usr/bin/python3

import fileinput
import re

pn=re.compile("^ *(\+[0-9]{2}|\([0-9]{2}\)|[0-9]{4}) [0-9]{10} *$")
for line in fileinput.input():
  line=line.rstrip()
  if re.match(pn,line):
    print(line)
