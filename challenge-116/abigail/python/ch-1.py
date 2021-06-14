#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

def make_sequence (string, start):
    if string == start:
        return [start]

    if 0 == string . find (start):
        tail = string [len (start) :]
        result = make_sequence (tail, str (int (start) + 1)) or \
                 make_sequence (tail, str (int (start) - 1))
        if result:
            return [start] + result

    return None


for line in fileinput . input ():
    line = line . strip ()
    for i in range (0, len (line)):
        result = make_sequence (line, line [0 : i + 1])
        if result:
            print ("," . join (result))
            break
