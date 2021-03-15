#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-2.py < input-file
#

import fileinput

#
# Working from the end of the required string backwards, we alternate
# placing a hash, and placing a number. We place them in an array @out,
# and at the end, print out said array in reverse order.
#
for index in fileinput . input ():
    index = int (index)
    out = []
    hash = 0
    while index > 0:
        hash = not hash
        if hash:
            out . append ("#")
            index = index - 1
        else:
            out . append (str (index + 1))
            index = index - len (str (index + 1))
    out . reverse ()
    print ("" . join (out))
