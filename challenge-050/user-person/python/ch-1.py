#!/usr/bin/env python3

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-050/         #
#                                                                         #
# Merge Intervals                                                         #
# Write a script to merge the given intervals where ever possible.        #
#                                                                         #
# [2,7], [3,9], [10,12], [15,19], [18,22]                                 #
#                                                                         #
# The script should merge [2, 7] and [3, 9] together to return [2, 9].    #
#                                                                         #
# Similarly it should also merge [15, 19] and [18, 22] together to        #
# return [15, 22].                                                        #
#                                                                         #
# The final result should be something like below:                        #
#                                                                         #
# [2, 9], [10, 12], [15, 22]                                              #
#                                                                         #
###########################################################################

import re
import sys

input = "[2,7], [3,9], [10,12], [15,19], [18,22]"

if len(sys.argv) > 1:
    input = ' '.join(sys.argv[1:])

input = re.sub(r'[][, ]+',' ',input)
input = re.sub(r'\A\s+|\s+\Z','',input)
sets = re.split(r' ',input)

def printSets(sList):
    lastInd = len(sList)-1
    for k in range(0, lastInd, 2):
        print('[' + str(sList[k]) + ', ' + str(sList[k+1]) + ']',end='')
        if lastInd > k+2:
            print(', ',end='')
    print()

def mergeUnits(inds):

    indsVal = [sets[pos] for pos in inds]
    indsVal.sort(key=int)
    sets.append(indsVal[0])
    sets.append(indsVal[3])

    inds.sort(key=int,reverse=True)
    for ind2pop in inds:
        sets.pop(ind2pop)

print('UNMERGED:')
printSets(sets)        

loop = True
while loop:

    loop = False
    for i in range(0, len(sets)-1, 2):

        for j in range(0, len(sets)-1, 2):

            if i == j:
                continue

            elif int(sets[j]) >= int(sets[i]) and int(sets[j]) <= int(sets[i+1]) or int(sets[j+1]) >= int(sets[i]) and int(sets[j+1]) <= int(sets[i+1]):
                # Elegant? no, but it seems to work.

                mergeUnits([i, i+1, j, j+1])
                loop = True
                break
        else:
            continue

        break

print('\nMERGED:')
sets.sort(key=int)
printSets(sets)
