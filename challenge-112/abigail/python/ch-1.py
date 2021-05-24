#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    parts  = line . rstrip () . split ("/")   # Split input on /
    parts2 = []
    for part in parts:
        if part == "" or part == ".":         # Skip empty parts,
            continue                          # and current directory.
        if part == "..":                      # Pop parent directory
            if len (parts2):
                parts2 . pop ()
            continue
        parts2 . append (part)                # Else, append.
    print ("/" + "/" . join (parts2))         # Print result.
