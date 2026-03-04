#!/usr/bin/env perl

import re
import sys

str = sys.argv[1].upper()
str, count = re.subn(r'(.)\1*', r'\1', str)

print(len(str)-1)
