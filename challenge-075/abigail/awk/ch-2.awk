#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#


{
    max_height = 0
    for (i = 1; i <= NF; i ++) {
        height [i] = $i
        if (height [i] > max_height) {
            max_height = height [i]
        }
    }

    max_area = 0;

    #
    # For each height, determine the maximum rectangle
    # which fits -- which means we need to maximum amount
    # of consequitive columns which are at least that heigh.
    #

    for (h = 1; h <= max_height; h ++) {
        max = 0;
        cur = 0;
        for (i = 1; i <= NF; i ++) {
            if (height [i] >= h) {
                cur ++
            }
            else {
                if (cur > max) {
                    max = cur
                }
                cur = 0
            }
        }
        if (cur > max) {
            max = cur
        }

        area = max * h
        if (area > max_area) {
            max_area = area
        }
    }

    print (max_area)
}
