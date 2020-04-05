#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/         #
#                                                                         #
# Collatz Conjecture                                                      #
# Contributed by Ryan Thompson                                            #
#                                                                         #
# It is thought that the following sequence will always reach 1:          #
# $n = $n / 2 when $n is even                                             #
# $n = 3*$n + 1 when $n is odd                                            #
#                                                                         #
# For example, if we start at 23, we get the following sequence:          #
# 23 -> 70 -> 35 -> 106 -> 53 -> 160 -> 80 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1   #
#                                                                         #
# Write a function that finds the Collatz sequence for any positive       #
# integer.                                                                #
# Notice how the sequence itself may go far above the original starting   #
# number.                                                                 #
#                                                                         #
# Extra Credit                                                            #
# Have your script calculate the sequence length for all starting numbers #
# up to 1000000 (1e6), and output the starting number                     #
# and sequence length for the longest 20 sequences.perl                   #
#                                                                         #
###########################################################################

import os
import re
import sys

def msgExit():
    print(os.path.basename(sys.argv[0]),  "requires one positive integer as an argument (or extracredit).")
    exit(1)

high = {}

def checkHighKeys(key,keyCount,highKeys):
    if len(highKeys) == 20:
        highKeys = {k: v for k, v in sorted(highKeys.items(), key=lambda item: (item[1],item[0]))}
        if highKeys[list(highKeys)[0]] < keyCount:
            del highKeys[list(highKeys)[0]]
            highKeys[key] = keyCount
        elif highKeys[list(highKeys)[0]] == keyCount:
            if list(highKeys)[0] < key:
                del highKeys[list(highKeys)[0]]
                highKeys[key] = keyCount
    else:
        highKeys[key] = keyCount

    return highKeys

if len(sys.argv) != 2:
    msgExit()

n = sys.argv[1]
extraCredit = False
ecPattern = re.compile(r'-{0,2}extra[-~`!@#$%^&*=+|\\;:",.?/ ]?credit', flags=re.IGNORECASE)

if  ecPattern.search(str(n)):
    n = 2
    extraCredit = True
    sys.stderr.flush()
    sys.stderr.write('Allow time for calculations.\n')
    sys.stderr.write("        They finish when '#'s reach this point-> |\n")

elif re.search(r'\A\d+\Z',str(n)):
    n = int(n)
    if n < 1:
        msgExit()
    if n == 1:
        print(1)
        exit()
else:
    msgExit()
    
MAX = 1000000
i = n

while i <= MAX:
    count = 0

    while n != 1:
        if extraCredit:
            count += 1
        else:
            print(int(n),'-> ', end='',flush=True)

        if n % 2 == 0:          # EVEN
            n /= 2
        else:                   # ODD
            n = 3*n + 1

    if extraCredit:
        high = checkHighKeys(i, count, high)
        i += 1
        n = i

        if n % 20000 == 0:
            sys.stderr.write('#')
            sys.stderr.flush()
    else:
        print(1)
        break

if extraCredit:
    sys.stderr.write('\n\n')
    high = {k: v for k, v in sorted(high.items(), key=lambda item: (item[1],item[0]),reverse=True)}
    for thisKey in high.keys():
        print('Starting number:', thisKey, 'with sequence length:',  high[thisKey])
