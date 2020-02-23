#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/
#
#               Survivor
#
#               There are 50 people standing in a circle in position 1 to 50. The person standing at position 1 has a sword. He kills the next person i.e. standing at position 2 and pass on the sword to the immediate next i.e. person standing at position 3. Now the person at position 3 does the same and it goes on until only one survives.
#
#               Write a script to find out the survivor.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 02/21/2020 09:15:59 PM
#     REVISION: ---
#===============================================================================

from collections import deque

def get_last_man_standing(count):

    people = deque(range(count))
    killed = 0
    switch = 0

    while killed < count-1:
        if switch == 0:
            switch = 1
            people.rotate(-1)
        else:
            switch = 0
            people.popleft()
            killed += 1

    return people.popleft()+1

print(get_last_man_standing(50))

# TESTS

assert(get_last_man_standing(50) == 37)
assert(get_last_man_standing(2) == 1)
assert(get_last_man_standing(3) == 3)
