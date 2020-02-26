#!/usr/bin/env perl6

# ch-2.p6 - Convert numbers to/from base35
#
# Ryan Thompson <rjt@cpan.org>

use v6;

.say for <0 34 35 69 70 1170605>».base(35);
.say for <0  Y 10 1Y 20    Raku>».parse-base(35);
