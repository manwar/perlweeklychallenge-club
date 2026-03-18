#!/usr/bin/env python3

# Perl Weekly Challenge 287 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-287/

import re
import sys

if re.search(r'  ^ [-+]?                '+
             r'    (?: \d+ \. \d* |     '+
             r'        \d* \. \d+ |     '+
             r'        \d+              '+
             r'    )                    '+
             r'    (?: e [-+]? \d+ )?   '+
             r'  $', sys.argv[1], re.X+re.I):
    print('true')
else:
    print('false')
