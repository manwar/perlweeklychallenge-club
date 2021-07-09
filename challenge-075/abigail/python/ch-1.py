#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

def possibilities (target, coins, first, last):
    if target == 0:
        return 1

    if target < 0 or first > last:
        return 0

    sum = 0
    for i in range (1 + int (target / coins [first])):
        sum = sum + possibilities (target - i * coins [first],
                                                coins, first + 1, last)

    return sum

for line in fileinput . input ():
    coins = list (map (lambda _: int (_), line . split (" ")))
    print (possibilities (coins [0], coins, 1, len (coins) - 1))
