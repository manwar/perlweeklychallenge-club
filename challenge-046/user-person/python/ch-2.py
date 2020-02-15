#!/usr/bin/python

###########################################################################
# script name: ch-2.py                                                    #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/         #
#                                                                         #
###########################################################################

MAX   = 500
doors = ["CLOSED" for i in range(MAX+1)]

def change (doorStatus):
    returnString = "OPENED"
    if doorStatus == "OPENED":
        returnString = "CLOSED"
    return returnString

for i in range(1,MAX):
    if i > MAX/2:
        doors[i] = change(doors[i])
        continue

    for j in range(1,MAX):
        if j % i == 0:
            doors[j] = change(doors[j])

for k in range(1,MAX):            
    if doors[k] == "OPENED":
        print(k,end=" ")

print()

# ch-2.py output:
#                 1 4 9 16 25 36 49 64 81 100 121 144 169 196 225 256 289 324 361 400 441 484
