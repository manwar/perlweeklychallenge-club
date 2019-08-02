#! /usr/bin/env perl6

.say if $_ %% $_.comb.sum for 0 .. 50;
