#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/         #
#                                                                         #
# kth Permutation Sequence                                                #
# Write a script to accept two integers n (>=1) and k (>=1).              #
# It should print the kth permutation of n integers.                      #
# For more information, please follow the wiki page.                      #
# https://en.wikipedia.org/wiki/Permutation#k-permutations_of_n           #
# For example, n=3 and k=4,                                               #
# the possible permutation sequences are listed below:                    #
#                                                                         #
#   123                                                                   #
#   132                                                                   #
#   213                                                                   #
#   231                                                                   #
#   312                                                                   #
#   321                                                                   #
# The script should print the 4th permutation sequence 231.               #
#                                                                         #
###########################################################################

from itertools import permutations
import os
import re
import sys

def msgExit():
    print(os.path.basename(sys.argv[0]),  " requires 2 arguments. The first argument to determine the sequence ( 1 >= ),\nThe second argument to determine which entry to print. Both arguments should be >= 1 .\n");
    exit(1)

def printSmooshed(ints):
    for num in ints:
        print(num,end='')
    print()
    
if len(sys.argv) != 3: 
          msgExit()
          
n = int(sys.argv[1])
k = int(sys.argv[2])

if re.search(r'\A\d+\Z', str(n)) and re.search(r'\A\d+\Z', str(k)):
     if n < 1 or k < 1:
         msgExit()
else:
    msgExit()              

kth = 1;
failure = True

for i in permutations(range(1,n)):
    if kth == k:
        printSmooshed(i)
        failure = False
        break
    else:
        kth += 1

if failure:
    print('There is no ' +  str(k) + "-th number in the '" + str(n) + " sequence'.")
