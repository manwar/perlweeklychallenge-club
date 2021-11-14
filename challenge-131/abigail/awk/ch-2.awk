#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

NR == 1 {
    n = split ($0, delims, "")
}

NR == 2 {
    m = split ($0, chars, "")
    out1 = ""
    out2 = ""
    for (i = 1; i <= m; i ++) {
        for (j = 1; j <= n; j += 2) {
            if (delims [j] == chars [i]) {
                out1 = out1 delims [j]
                break
            }
        }
        for (j = 2; j <= n; j += 2) {
            if (delims [j] == chars [i]) {
                out2 = out2 delims [j]
                break
            }
        }
    }
    print out1
    print out2
}
