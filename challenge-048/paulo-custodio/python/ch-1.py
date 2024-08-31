#!/usr/bin/env python3

# Challenge 048
#
# TASK #1
# Survivor
# There are 50 people standing in a circle in position 1 to 50. The person
# standing at position 1 has a sword. He kills the next person i.e. standing at
# position 2 and pass on the sword to the immediate next i.e. person standing at
# position 3. Now the person at position 3 does the same and it goes on until
# only one survives.
#
# Write a script to find out the survivor.

people = [x for x in range(1, 51)]
p = 0
while len(people) > 1:
    if p >= len(people)-1:
        people = people[1:]
    else:
        people = people[0:p+1]+people[p+2:]
    p += 1
    if p >= len(people):
        p = 0
print(people[0])
