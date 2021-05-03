#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

outputs = []

#
# Read input, split on commas, build output strings.
#
for line in fileinput . input ():
    fields = line . rstrip () . split (",")
    if (len (outputs)):
        for i in range (len (fields)):
            outputs [i] = outputs [i] + "," + fields [i]
    else:
        outputs . extend (fields)

#
# Print output lines
#
for line in outputs:
    print (line)
