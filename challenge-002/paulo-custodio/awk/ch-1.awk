#!/usr/bin/gawk

# Challenge 002
#
# Challenge #1
# Write a script or one-liner to remove leading zeros from positive numbers.

BEGIN {
    num = ARGV[1];
    if (match(num, /^0*([0-9]+)/, capture))
        print capture[1];
    else
        print num;
    exit 0;
}
