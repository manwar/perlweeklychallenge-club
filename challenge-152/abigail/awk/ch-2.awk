#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: awk -f ch-2.awk < input-file
#

function min (a, b) {return a < b ? a : b}
function max (a, b) {return a < b ? b : a}

{
    print ((max($1, $3) - min($1, $3))  * \
           (max($2, $4) - min($2, $4))  + \
           (max($5, $7) - min($5, $7))  * \
           (max($6, $8) - min($6, $8))  - \
 max(0, min(max($1, $3),  max($5, $7))  - \
        max(min($1, $3),  min($5, $7))) * \
 max(0, min(max($2, $4),  max($6, $8))  - \
        max(min($2, $4),  min($6, $8))))
}
