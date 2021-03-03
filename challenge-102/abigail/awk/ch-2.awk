#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

#
# Working from the end of the required string backwards, we alternate
# placing a hash, and placing a number. We place them in an array out,
# and at the end, print out said array in reverse order.
#

{
    idx  = $1
    hash = 0
    i    = 0
    while (idx) {
        i ++
        if (hash = !hash) {
            out [i] = "#"
            idx --
        }
        else {
            out [i] =       idx + 1
            idx  -= length (idx + 1)
        }
    }
    for (; i; i --) {
        printf "%s", out [i]
    }
    printf "\n"
}
