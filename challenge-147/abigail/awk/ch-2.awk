#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: awk -f ch-2.awk
#

BEGIN {
    while (!done) {
        p += n + n + n ++ + 1
        pentagon [p] = 1

        for (seen in pentagon) {
            if (seen + seen < p && (p - seen)        in pentagon \
                                && (p - seen - seen) in pentagon ) {
                print seen, p - seen
                done = 1
                break
            }
        }
    }
}

