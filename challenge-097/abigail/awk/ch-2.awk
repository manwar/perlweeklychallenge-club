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
    sum = 0
    s_len = length ($0) / sections  # Length of a section
    for (i = 0; i < s_len; i ++) {
        zeros = 0;    # Count the zeros on position i
        for (j = 0; j < sections; j ++) {
            indx = j * s_len + i + 1     # Can't use 'index' as a variable
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

