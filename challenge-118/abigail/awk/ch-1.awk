#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

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
    bin = dec2bin($1)
    l   = length (bin)
    #
    # Check if it's a palindrome
    #
    for (i = 1; i < l / 2; i ++) {
        if (substr (bin, i, 1) != substr (bin, l - i + 1, 1)) {
            print (0)
            next
        }
    }
    print (1)
}

