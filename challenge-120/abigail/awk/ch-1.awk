#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    out = 0
    num = $1
    for (i = 0; i < 8; i ++) {
        bit = int ((num - (num % 2 ^ i)) / 2 ^ i) % 2;
        if (bit) {
            out += 2 ^ (i + (i % 2 ? -1 : 1))
        }
    }
    print out
}
