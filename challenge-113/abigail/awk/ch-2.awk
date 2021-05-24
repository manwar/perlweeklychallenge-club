#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    sum = 0
    for (i = 1; i <= NF; i ++) {
        sum += $i
    }
    for (i = 1; i <= NF; i ++) {
        if (i > 1) {
            printf " "
        }
        printf "%d", sum - $i
    }
    printf "\n"
}
