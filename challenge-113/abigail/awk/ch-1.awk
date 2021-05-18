#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    split ("0 1 2 1 0 2 6 3 8", tens)
}

{
    N = $1
    D = $2
    D10 = D == 0 ? 100 : D * 10
    if (N >= D10 || N % (D == 0 ? 10 : D) == 0) {
        print 1
        next
    }
    for (i = 1; i <= tens [D]; i ++) {
        T = N - 10 * i - D
        if (T >= 0 && T % D == 0) {
            print 1
            next
        }
    }
    print 0
}
