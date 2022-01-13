#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py
#

BASE  = 10
COUNT =  5

def is_long (number):
    seen = [0] * number
    rest = 0
    for _ in range (1, number):
        rest = (rest * BASE + BASE - 1) % number
        if seen [rest] == 1:
            return False
        seen [rest] = 1
    return True


number = 1
while COUNT > 0:
    number = number + 1
    if BASE % number == 0:
        continue
    if is_long (number):
        print (number)
        COUNT = COUNT - 1
