#!/usr/bin/env python3

# Perl Weekly Challenge 280 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-280/

import sys
import re

str_input = sys.argv[1] if len(sys.argv) > 1 else ""
str_input = re.sub(r'\|[^|]*\|', '', str_input)
count = str_input.count('*')
print(count)
