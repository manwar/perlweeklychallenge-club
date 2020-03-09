#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/         #
#                                                                         #
# Noble Integer                                                           #
# You are given a list, @L, of three or more random integers between 1    #
# and 50. A Noble Integer is an integer N in @L, such that there are      #
# exactly N integers greater than N in @L. Output any Noble Integer       #
# found in @L, or an empty list if none were found.                       #
#                                                                         #
# An interesting question is whether or not there can be multiple Noble   #
# Integers in a list.                                                     #
#                                                                         #
# For example,                                                            #
#                                                                         #
# Suppose we have list of 4 integers [2, 6, 1, 3].                        #
#                                                                         #
# Here we have 2 in the above list, known as Noble Integer, since there   #
# are exactly 2 integers in the list i.e.3 and 6, which are greater than  #
# 2.                                                                      #
#                                                                         #
# Therefore the script would print 2.                                     #
#                                                                         #
###########################################################################

import re
import sys

def nobleInt(ints):
    seen = dict()
    ints.sort(key=int)
   
    for i in ints:
        count = 0

        for j in ints:

            if int(i) < int(j):
                count += 1

        if int(count) == int(i):
            if i in seen:
                seen[i] += 1
            else:
                seen.update({i:1})
    return seen.keys()

input = "[2, 6, 1, 3]"

if len(sys.argv) > 1:
     input = ' '.join(sys.argv[1:])
else:
    print('default input:',input)
     
input = re.sub(r'[][, ]+', ' ', input)
input = re.sub(r'\A\s+|\s+\Z', '', input)
L     = re.split(r' ', input)

nobleInteger = nobleInt(L)

if nobleInteger:
    for kys in nobleInteger:
        print('noble integer:',kys)
else:
    print('No noble integer.')
