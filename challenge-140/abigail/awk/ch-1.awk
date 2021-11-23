#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

#
# Take a binary representation, return its decimal equivalent
#
function bin2dec (bin, dec, digits, n) {
    dec = 0
    n = split (bin, digits, "")
    for (i = 1; i <= n; i ++) {
        dec = 2 * dec + digits [i]
    }
    return (dec)
}


#
# Get a binary representation
#
function dec2bin (dec, bin) {
    while (dec) {
        bin = dec % 2 bin
        dec = int (dec / 2)
    }
    return (bin)
}


{
    print dec2bin(bin2dec($1) + bin2dec($2))
}
