#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    for (i = 1; i <= $0; i ++) {
        print (i % 15 == 0) ? "fizzbuzz"  \
            : (i %  5 == 0) ? "buzz"      \
            : (i %  3 == 0) ? "fizz"      \
            :                  i
    }
}
