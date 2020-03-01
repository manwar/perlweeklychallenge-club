#!/usr/bin/env python3

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-049/         #
#                                                                         #
# LRU Cache                                                               #
# Write a script to demonstrate LRU Cache feature. It should support      #
# operations get and set. Accept the capacity of the LRU Cache as         #
# command line argument.                                                  #
#                                                                         #
# Definition of LRU: An access to an item is defined as a get or a set    #
# operation of the Least recently  item is the one with the oldest access #
# time.                                                                   #
#                                                                         #
###########################################################################

import os
import re
import readline
import sys

if (len(sys.argv) < 2):
    badArgString = os.path.basename(__file__) + " requires one argument to assign LRU's capacity, but none was given.\n"
    sys.stderr.write(badArgString)
    sys.exit(1)

CAPACITY = sys.argv[1]

capacityMatch = re.search("\A\d+\Z", CAPACITY)
if not capacityMatch:
    sys.stderr.write('Command line argument assigns capacity. It should be an integer.\n')
    sys.exit(1)
else:
    print('capacity = ', CAPACITY)

cIndex = []
cache  = dict()

def showCache():
    print('[Least recently used] ',end='')
    for i in range(len(cIndex)):
        print(cIndex[i],end='')
        print(' ',end='') if i == len(cIndex)-1 else print(', ',end='')
    print('[most recently used]\n')

def lruSet(lruPos,lruVal):
    if lruPos in cache.keys():
        print('position ', lruPos, ' currently occupied in cache\n')
    else:
        cIndex.append(lruPos)
        cache[lruPos] = lruVal

        if len(cIndex) == int(CAPACITY):
            print('\nCache at this point:')
            showCache()
            
        elif len(cIndex) > int(CAPACITY):
            popped = cIndex.pop(0)
            del cache[popped]
            print('\nCache is full, so pushes out key = ' + popped + ':')
            showCache()

def lruGet(lruInd):
    lruGetRet = -1

    if lruInd in cache.keys():
        moveInd = cIndex.index(lruInd)
        if moveInd != len(cIndex)-1:
            cIndex.append(cIndex.pop(moveInd))

        lruGetRet = cache[lruInd]
    return lruGetRet

while True:
    cmd = input()

    setPat = re.compile(r's(?:et)?[( ]?(\d+)\)?(?:\s+|\,)[( ]?(\d+)\)?',re.I)
    setMatch = re.match(setPat, cmd)
    getPat = re.compile(r'g(?:et)?[( ]?(\d+)\)?', re.I)
    getMatch = re.match(getPat, cmd)
    
    if re.search(r'x|q|exit|quit', cmd, re.I):
        break

    elif setMatch:
        lruSet(setMatch.group(1),setMatch.group(2))

    elif getMatch:
        lruRet = lruGet(getMatch.group(1))

        if lruRet == -1:
            print('            # returns -1\n\nCache unchanged:')
        else:
            print('            # returns ', lruRet, '\n\nCache looks like now:')

        showCache()

    else:
       elseError = '\nunrecognized input: $cmd\nset(#,#) get(#), exit, quit, x, q are valid inputs\n'
       sys.stderr.write(elseError)