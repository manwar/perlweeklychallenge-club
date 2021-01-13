#!/usr/bin/env perl6

# ch-2.p6 - Niven numbers from 0..50
#
# Ryan Thompson <rjt@cpan.org>

.say for (0..50).grep: { $_ %% .comb.sum }
