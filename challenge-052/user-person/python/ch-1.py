#!/usr/bin/env python3

###########################################################################
# script name: ch-1-CORRECTED.py                                          #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/         #
#                                                                         #
# Stepping Numbers                                                        #
#                                                                         #
# Write a script to accept two numbers between 100 and 999. It should     #
# then print all Stepping Numbers between them.                           #
#                                                                         #
# A number is called a stepping number if the adjacent digits have a      #
# difference of 1. For example, 456 is a stepping number but 129 is not.  #
#                                                                         #
###########################################################################

import os
import re
import sys

step = []
UPPER_LIMIT = 1000
LOWER_LIMIT = 99

for i in range(1,10):
    if i < 8:                   # UP UP
        step.append( (i * 100) + ((i+1) * 10) + (i+2) )

    if i > 1:                   # DOWN DOWN
        step.append( (i * 100) + ((i-1) * 10) + (i-2) )

    if i < 9:                   # UP DOWN
        step.append( (i * 100) + (i+1) * 10 + i )

    step.append( (i * 100) + (i-1) * 10 + i ) # DOWN UP

step.sort()

errorString = os.path.basename(sys.argv[0]) + ' requires 2 arguments between 100 and 999.'

if len(sys.argv) != 3:
    print(errorString)
    exit(1)

args = [int(arg) for arg in sys.argv[1:]]
        
for arg in args:
    if arg < LOWER_LIMIT or arg > UPPER_LIMIT:
        print(errorString)
        exit(1)

max = min = 0

if args[0] < args[1]:
    min = args[0]
    max = args[1]
elif args[1] < args[0]:
    min = args[1]
    max = args[0]
else:
    max = min = args[0]

commaFlag = False

if step[0] > max or step[-1] < min:
    exit(0)

for num in step:
    if num >= min and num <= max:
        if commaFlag:
            print(', ', end='')
        print(num, end='')
        commaFlag = True
    elif commaFlag:
        break

if commaFlag:
    print()
