#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    #
    # Initialize digits array
    #
    for (i = 0; i < 10; i ++) {
        digits [i] = 0
    }

    #
    # Read in the data; count digits
    #
    for (i = 1; i <= NF; i ++) {
        digits [$i] ++
    }

    #
    # Find the smallest even number; this one goes last
    #
    last = -1
    for (i = 0; i < 10 && last < 0; i += 2) {
        if (digits [i] > 0) {
            last = i
            digits [i] --
        }
    }

    #
    # Skip if the input does not contain an even digit
    #
    if (last < 0) {
        next
    }

    #
    # Create the output: rest of digits are from highest to lowest
    #
    out = ""
    for (i = 9; i >= 0; i --) {
        while (digits [i] -- > 0) {
            out = out i
        }
    }
    print out last
}


