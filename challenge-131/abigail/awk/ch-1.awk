#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    prev = 0
    for (i = 1; i <= NF; i ++) {
        printf ("%s%d", prev == 0 ? "" : (prev + 1 == $i) ? " " : "\n",
                       (prev = $i))
    }
    printf ("\n")
}
