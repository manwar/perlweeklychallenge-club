#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/         #
#                                                                         #
# Smallest Multiple                                                       #
# Write a script to accept a positive number as command line argument     #
# and print the smallest multiple of the given number consists of digits  #
# 0 and 1.                                                                #
#                                                                         #
###########################################################################

import sys
import re

num = int(sys.argv[1])
add = num

while re.search(r'[^01]',str(num)):
    num += add
    
print(num)
