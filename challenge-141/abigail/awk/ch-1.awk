#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk
#

BEGIN {
    count          = 10;
    nr_of_divisors =  8;

    for (n = 1; count > 0; n ++) {
        s = int sqrt (n);
        if (n == s * s) {
            continue
        }
        c = 0;
        for (m = 1; m <= s && c <= nr_of_divisors; m ++) {
            if (n % m == 0) {
                c += 2
            }
        }
        if (c == nr_of_divisors) {
            print (n)
            count --
        }
    }
}
