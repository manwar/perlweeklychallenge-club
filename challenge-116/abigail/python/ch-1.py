#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

def make_chain (string, start):
    if string == start:
        return [start]

    if 0 == string . find (start):
        tail = string [len (start) :]
        result = make_chain (tail, str (int (start) + 1)) or \
                 make_chain (tail, str (int (start) - 1))
        if result:
            return [start] + result

    return None


for line in fileinput . input ():
    line = line . strip ()
    for i in range (0, len (line)):
        result = make_chain (line, line [0 : i + 1])
        if result:
            print ("," . join (result))
            break
