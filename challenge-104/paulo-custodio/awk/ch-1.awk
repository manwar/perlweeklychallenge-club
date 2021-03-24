#!/usr/bin/gawk

# Challenge 104
#
# TASK #1 › FUSC Sequence
# Submitted by: Mohammad S Anwar
# Write a script to generate first 50 members of FUSC Sequence. Please refer to
# OEIS for more information.
#
# The sequence defined as below:
#
# fusc(0) = 0
# fusc(1) = 1
# for n > 1:
# when n is even: fusc(n) = fusc(n / 2),
# when n is odd: fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

function fusc(n) {
    if (n==0)
        return 0
    else if (n==1)
        return 1
    else if ((n % 2)==0)    # even
        return fusc(n/2)
    else                    # odd
        return fusc((n-1)/2) + fusc((n+1)/2)
}

BEGIN {
    num = ARGV[1]
    for (i = 0; i < num; i++)
        printf "%d ", fusc(i)
    print ""

    exit 0
}
