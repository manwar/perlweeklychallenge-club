#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-053/         #
#                                                                         #
# Vowel Strings                                                           #
#                                                                         #
# Write a script to accept an integer 1 <= N <= 5 that would print all    #
# possible strings of size N formed by using only vowels (a, e, i, o, u). #
# The string should follow the following rules:                           #
#                                                                         #
# 1. 'a' can only be followed by 'e' and 'i'.                             #
# 2. 'e' can only be followed by 'i'.                                     #
# 3. 'i' can only be followed by 'a', 'e', 'o', and 'u'.                  #
# 4. 'o' can only be followed by 'a' and 'u'.                             #
# 5. 'u' can only be followed by 'o' and 'e'.                             #
#                                                                         #
###########################################################################

import os
import re
import sys

# https://is.gd/lOmciv
def toStr(n,base):
    convertString = "01234"
    if n < base:
        return convertString[n]
    else:
        return toStr(n//base,base) + convertString[n%base]

scriptName = os.path.basename(sys.argv[0])

num = 0

try:
    num = int(sys.argv[1])
except IndexError:
    sys.stderr.write(scriptName + ' requires an argument. Argument should be 1 <= n <= 5\n')
    exit(1)

if num < 1 or num > 5:
    sys.stderr.write('Invalid choice. Argument should be 1 <= n <= 5\n')
    exit(1)

vowels = ( 'a', 'e', 'i', 'o', 'u')
MAX = int('4' * num,5) 

j = 0
for i in range(0,MAX):
    j = int(toStr(i,5))

    j = '{number:0{size}d}'.format(number=j,size=num)

    string = ''
    for k in str(j):
        string += vowels[int(k)]

    if re.search(r'a[^ei]',string) \
            or  re.search(r'e[^i]',string) \
            or  re.search(r'o[^au]',string) \
            or  re.search(r'i[^aeou]',string) \
            or  re.search(r'u[^oe]',string):
        continue
    else:
         print(string)
