#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    for (i = 1; i <= NF; i ++) {
        board [NR, i] = $i
    }
    X = NR
    Y = NF
}

END {
    for (x = 1; x <= X; x ++) {
        for (y = 1; y <= Y; y ++) {
            if (board [x, y] == "x") {
                if (y > 1) {
                    printf (" ")
                }
                printf (board [x, y])
                continue
            }
            count = 0
            for (dx = -1; dx <= 1; dx ++) {
                if (x + dx < 1 || x + dx > X) {
                    continue
                }
                for (dy = -1; dy <= 1; dy ++) {
                    if (y + dy < 1 || y + dy > Y ||
                        (dx == 0 && dy == 0)) {
                        continue
                    }
                    if (board [x + dx, y + dy] == "x") {
                        count ++
                    }
                }
            }
            if (y > 1) {
                printf (" ")
            }
            printf (count)
        }
        printf ("\n")
    }
}


