#!/opt/homebrew/bin/python3

import sys

for line in sys . stdin:
    #
    # Split the input into words; first one is the number of set
    #
    list = line . rstrip ("\n") . split ()
    n    = int (list [0])
    list = list [1:]

    #
    # Special case if n exceeds the size of the list
    #
    if n > len (list):
        print ("-1;")
        continue

    #
    # Calculate the size of the sets, and the number of 
    # sets which gets one more
    #
    per_set  = len (list) // n
    overflow = len (list) -  n * per_set

    #
    # Print sets
    #
    for i in range (n):
        #
        # Calculate the size of the current set
        #
        set_size = per_set
        if i < overflow:
            set_size = set_size + 1
        #
        # Print the current set, and adjust the list
        #
        print (" " . join (list [:set_size]) + "; ", end = '')
        list = list [set_size:]

    print ("")
