#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

#
# See ../README.md for description of the how the method works
#
def long_division (numerator, denominator):
    BASE      = 10
    fraction  = str (numerator // denominator) + "."
    position  = len (fraction)
    seen      = {}

    numerator = numerator % denominator

    while not (numerator in seen):
        if numerator == 0:
            return (fraction)
        seen [numerator] = position
        fraction  = fraction + str (BASE * numerator // denominator)
        numerator =                 BASE * numerator  % denominator
        position  = position + 1

    return (fraction [:seen [numerator]]  + "(" +
            fraction [ seen [numerator]:] + ")")


for line in fileinput . input ():
    print (long_division (*map (lambda _: int (_), line . split ())))
