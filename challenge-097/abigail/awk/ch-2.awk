#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk -s SIZE < input-file
#

BEGIN {
    #
    # Parse command line
    #
    for (i = 1; i < ARGC; i ++) {
        if (ARGV [i] == "-s") {
            size = ARGV [i + 1]
        }
    }
    ARGC = 0
}

{
    #
    # Split the string into individual letters, use 
    # indexing to get the ith letter of the jth section
    #
    sum = 0
    sections = length ($0) / size
    for (i = 0; i < size; i ++) {
        zeros = 0;    # Count the zeros on position i
        for (j = 0; j < sections; j ++) {
            indx = j * size + i + 1     # Can't use 'index' as a variable
            if (substr ($0, indx, 1) == "0") {
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

