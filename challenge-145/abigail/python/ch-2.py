#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    palindromes = {}
    out         = ""
    for i in range (0, len (line)):
        for j in range (i + 1, len (line)):
            string = line [i : j]
            if string == string [::-1]:
                if not (string in palindromes):
                    palindromes [string] = 1
                    out = out + string + " "
    print (out)
