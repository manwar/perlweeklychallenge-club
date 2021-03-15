#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

#
# Read in the triangle
#
{
    for (i = 1; i <= NF; i ++) {
        nums [NR, i] = $i
    }
}

#
# Calculate the minimum path bottom to top
#
END {
    for (x = NR - 1; x >= 0; x --) {
        for (y = 1; y <= x; y ++) {
            if (nums [x + 1, y] < nums [x + 1, y + 1]) {
                nums [x, y] += nums [x + 1, y]
            }
            else {
                nums [x, y] += nums [x + 1, y + 1]
            }
        }
    }
    print nums [1, 1]
}
