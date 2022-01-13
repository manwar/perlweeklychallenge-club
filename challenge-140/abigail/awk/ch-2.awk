#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    i = $1
    j = $2
    k = $3

    n = 0
    while (k > 0) {
        n ++
        s = int (sqrt (n))
        for (d = 1; d <= s && k > 0; d ++) {
            if (!(n % d)) {
                k -= (d <= i && n / d <= j) + \
                     (d <= j && n / d <= i) - (n == d * d)
            }
        }
    }
    print (n)
}

