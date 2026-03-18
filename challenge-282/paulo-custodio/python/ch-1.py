#!/usr/bin/env python3

# Perl Weekly Challenge 282 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-282/

import re
import sys

found = re.search(r'((\d)\2\2+)', sys.argv[1])
if found is None:
    print(-1)
elif len(found.group(1)) != 3:
    print(-1)
else:
    print(found.group(1))
