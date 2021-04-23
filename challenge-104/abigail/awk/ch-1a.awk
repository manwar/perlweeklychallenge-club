#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1a.awk < input-file
#

#
# Instead of doing the simple thing (print a fixed string), which
# we've done in ch-1.awk, here we will actually calculate the numbers.
#

#
# Initialize the cache
#
BEGIN {
    cache [0] = 0
    cache [1] = 1
}

#
# Calculate the nth FUSC number, using a cache.
#
function fusc (n) {
    if (!(n in cache)) {
        cache [n] = n % 2 ? fusc((n - 1) / 2) + fusc((n + 1) / 2) \
                          : fusc( n      / 2)
    }
    return (cache [n])
}

#
# Print the first 50 numbers.
#
BEGIN {
    for (i = 0; i < 50; i ++) {
        printf "%s%d", (i == 0 ? "" : " "), fusc(i)
    }
    print
}

