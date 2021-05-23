#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    numbers = list (map (lambda _: int (_), line . split ()))
    total = sum (numbers)
    print (' ' . join (map (lambda _: str (total - _), numbers)))
