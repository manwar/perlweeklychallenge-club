#!/usr/bin/env perl6

# challenge-033/ch-1.p6 - Count a..z characters in given files or stdin
#
# Ryan Thompson <rjt@cpan.org>

use v6;

.fmt('%s: %d').say for $*ARGFILES.comb».lc.Bag{'a'..'z'}:p;
