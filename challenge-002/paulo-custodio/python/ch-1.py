#!/usr/bin/env python

# Challenge 002
#
# Challenge #1
# Write a script or one-liner to remove leading zeros from positive numbers.

import sys
import re

print(re.sub(r"^0+(\d)", r"\1", sys.argv[1]))
