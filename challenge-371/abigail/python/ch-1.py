#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    #
    # Read the input, split on space, replace character by their values
    #
    letters = list (map (lambda l: ord (l), line . strip () . split (" ")))

    #
    # Find the index of the question mark
    #
    for i in range (len (letters)):
        if letters [i] == ord ("?"):
            qi = i
            break

    #
    # Get the character values we need to calculating the missing value
    #
    base = letters [qi + 1 if qi <= 2 else                        qi - 1]
    frm  = letters [qi + 3 if qi <  2 else qi - 1 if qi == 2 else qi - 3]
    to   = letters [qi + 2 if qi <  2 else                        qi - 2]

    #
    # Calculate the missing value and print it
    #
    print (chr (base - frm + to))
