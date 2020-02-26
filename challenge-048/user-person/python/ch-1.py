#!/usr/bin/env python

###########################################################################
# script name: ch-1.py                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/         #
#                                                                         #
# Survivor                                                                #
# There are 50 people standing in a circle in position 1 to 50.           #
# The person standing at position 1 has a sword. He kills the next person #
# i.e. standing at position 2 and pass on the sword to the immediate next #
# i.e. person standing at position 3. Now the person at position 3 does   #
# the same and it goes on until only one survives.                        #
#                                                                         #
#   Write a script to find out the survivor.                              #
#                                                                         #
###########################################################################

from optparse import OptionParser

parser = OptionParser()

parser.add_option("-v","--verbose",action="store_true", dest="verbose")
(options, args) = parser.parse_args()

circle = list(range(1,51))

i = 1

while len(circle) > 1:
    
    if options.verbose:
        print ("i : ",i)
    
    victim = circle.pop(i)

    if options.verbose:
        print(circle[i-1], " killed ", victim)
        print(*circle, sep =" ")
        print()

    # When the end of the array is reached,
    # roll back the index to go back around the circle for another iteration.
    # In odd cases the next victim will be 0. In even cases it will be 1.
    # These have to be adjusted due to the for loop's incrementing -1 for odd, 0 for even.

    if (len(circle)-1) - i == 0:
        i = -1

    elif (len(circle)-1) - i == -1   :
        i = 0

    i += 1

print(*circle, " survives")

# output:
#
# 37  survives
