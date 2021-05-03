#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

BEGIN {
    FS = ","    # This gives us an implicit split
}

{
    #
    # Build output strings in array out
    #
    for (i = 1; i <= NF; i ++) {
        out [i] = out [i] "," $i
    }
}

END {
    #
    # Print the output strings
    #
    for (i = 1; i <= length (out); i ++) {
        print substr (out [i], 2)
    }
}
