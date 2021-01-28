#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    row [1] = 1    # 0'th row
    printf "%d\n", row [1]

    for (r = 1; r <= $0; r ++) {
        #
        # Calculate the new row, and print it
        #
        for (i = 1; i <= length (row) + 1; i ++) {
            new [i] = (i == 1                ? 0 : row [i - 1]) +\
                      (i == length (row) + 1 ? 0 : row [i])
            printf ("%s%d", i == 1 ? "" : " ", new [i])
        }
        printf "\n";

        #
        # Copy the new row to the current row
        #
        for (i = 1; i <= length (new); i ++) {
            row [i] = new [i]
        }
    }
}
