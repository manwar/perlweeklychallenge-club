#!/usr/bin/env python3

# Perl Weekly Challenge 182 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-182/

import sys

in_list = sys.argv[1:]
result = sorted(((value, index) for index, value in enumerate(in_list)), key=lambda x: x[0], reverse=True)[0][1]
print(result)
