#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk -s SHIFT < input-file
#

BEGIN {
    NR_OF_LETTERS = 26
    ORD_A         = 65

    #
    # Create a letter to number mapping
    #
    for (i = ORD_A; i < ORD_A + NR_OF_LETTERS; i ++) {
        t = sprintf ("%c", i)
        ord [t] = i
    }

    #
    # Parse command line
    #
    for (i = 1; i < ARGC; i ++) {
        if (ARGV [i] == "-s") {
            shift = ARGV [i + 1]
        }
    }
    ARGC = 0
}

{
    out = ""
    #
    # Iterate over the individual letters, shifting capital letters
    #
    for (i = 1; i <= length (letters); i ++) {
        char = substr ($0, i, 1)
        if (ord [char]) {
            n = ord [char] - shift
            if (n < ORD_A) {
                n = n + NR_OF_LETTERS
            }
            char = sprintf ("%c", n)
        }
        out = out char
    }
    print out
}

