#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    #
    # Parse input. We need to make the size an integer. 'str' is a Python
    # function, which we want to use, so we name the variable 'string'.
    #
    [string, size, filler] = line . split ()
    size = int (size)

    #
    # Add (size - 1) filler characters. 
    #
    string = string + (filler * (size - 1))

    #
    # Repeatedly take the first size characters from the string,
    # and add them to the out array. Stop when the string has less 
    # than size characters (they will be all filler characters).
    #
    out = []
    while (len (string) >= size):
        out . append (string [:size])
        string = string [size:]

    #
    # Print the content of the array, space separated
    #
    print (" " . join (out))
