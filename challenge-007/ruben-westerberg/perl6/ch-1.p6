#!/usr/bin/env perl6
#
#niven numbers

say join "\n", (0..50) .grep({($_ > 0) && $_ %% (.Str.comb>>.Int .sum)});

