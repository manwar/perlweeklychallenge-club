#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk -s SECTIONS < input-file
#

BEGIN {
    #
    # Parse command line
    #
    for (i = 1; i < ARGC; i ++) {
        if (ARGV [i] == "-s") {
            sections = ARGV [i + 1]
        }
    }
    ARGC = 0
}

{
    #
    # Split the string into individual letters, use 
    # indexing to get the ith letter of the jth section
    #
    split ($0, letters, "")
    sum = 0
    l = length($0) / sections  # Length of a section
    for (i = 0; i < l; i ++) {
        zeros = 0;    # Count the zeros on position i
        for (j = 0; j < sections; j ++) {
            if (letters [j * l + i + 1] == "0") {
                zeros ++
            }
        }
        ones = sections - zeros
        #
        # Sum the minimum of the 0's and 1's
        #
        sum += zeros < ones ? zeros : ones
    }
    print sum
}

