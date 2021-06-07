#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    sum_of_squares = 0
    for (i = 1; i <= length ($1); i ++) {
        # Sum of squares
        sum_of_squares += substr ($1, i, 1) * substr ($1, i, 1)
    }
    root = int (.5 + int (sqrt (sum_of_squares)))
    print (sum_of_squares == root * root ? 1 : 0)
}
