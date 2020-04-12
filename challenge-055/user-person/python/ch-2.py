#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/         #
#                                                                         #
# Wave Array                                                              #
# Any array N of non-unique, unsorted integers can be arranged into a     #
# wave-like array such that n1 => n2 <= n3 => n4 <= n5 and so on.         #
# For example, given the array [1, 2, 3, 4], possible wave arrays         #
# include [2, 1, 4, 3] or [4, 1, 3, 2], since 2 => 1 <= 4 => 3 <=         #
# and 4 => 1 <= 3 => 2. This is not a complete list.                      #
# Write a script to print all possible wave arrays for an integer array   #
# N of arbitrary length.                                                  #
#                                                                         #
# Notes:                                                                  #
# When considering N of any length, note that the first element is        #
# always greater than or equal to the second, and then the <= => <=       #
# sequence alternates until the end of the array.                         #
#                                                                         #
###########################################################################

from itertools import permutations
import re
import sys

n = [ 1, 2, 3, 4]

if len(sys.argv) > 1:
    argString = ' '.join(sys.argv[1:])

    matchObj = re.match(r'\A\s*([[(\{<])\s*', argString)
    if matchObj:
        pair = { '[' : ']', '(' : ')', '{' : '}', '<' : '>'}
        pairMatch = pair[ matchObj.group(0) ]
        argString = re.sub(r'\A\s*[[(\{<]\s*','',argString)
        argString = re.sub('\s*'+re.escape(pairMatch)+'\s*\Z', '', argString)

    argString = re.sub(r'\s*,\s*',' ',argString)
    n = [int(x) for x in argString.split(" ")]

else:
    sys.stderr.write('No arguments given. Using example data: [1, 2, 3, 4]\n')

for num in n:
    if type(num) != int:
        sys.stderr.write('Non-numeric input detected.\n')
        sys.exit(1)

for set in permutations(n):
    i = 0

    for i in range(len(set)):
        if i == 0:
            continue

        if i % 2 == 0:          # EVEN
            if set[i-1] > set[i]:
                break
        else:                   # ODD
            if set[i-1] < set[i]:
                break
    else:
        for x in set:
            print(x,end=' ')
        else:
            print()
