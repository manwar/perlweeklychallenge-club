#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    #
    # Remove quotes and newline
    #
    line    = line . rstrip ("\n") . strip ("\"")

    #
    # Count spaces
    #
    spaces  = line . count (" ")

    #
    # Split into words. Since split keeps empty leading and trailing
    # fields, we first strip leading and trailing whitespace
    #
    words   = re . split (r' +', line . strip ())

    #
    # Number of gaps between the words
    #
    gaps    = len (words) - 1

    #
    # Calculate the amount of spaces needed
    #
    per_gap = spaces // gaps if gaps > 0 else 0
    end     = spaces -  gaps * per_gap

    #
    # Print results
    #
    print ('"' + (" " * per_gap) . join (words) + " " * end + '"')

