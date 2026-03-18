#!/usr/bin/env python

# Perl Weekly Challenge 282 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

import re
import sys

str = sys.argv[1].upper()
str, count = re.subn(r'(.)\1*', r'\1', str)

print(len(str)-1)
