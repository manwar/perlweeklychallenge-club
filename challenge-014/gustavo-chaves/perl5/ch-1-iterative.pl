#!/usr/bin/env perl

# Write a script to generate Van Eck’s sequence starts with 0. For more
# information, please check out wikipedia page
# (https://en.wikipedia.org/wiki/Van_Eck%27s_sequence). This challenge was
# proposed by team member Andrezgz.

# This is an iterative implementation, which is more than 30x faster than the
# recursive one.

use 5.026;
use strict;
use warnings;

my $sequence_size = shift or die "Usage: $0 SIZE\n";

my @sequence = (0);

VALUE:
for my $i (0 .. $sequence_size-2) {
    for (my $j=$i-1; $j >= 0; --$j) {
        if ($sequence[$j] == $sequence[$i]) {
            push @sequence, $i-$j;
            next VALUE;
        }
    }
    push @sequence, 0;
}

say foreach @sequence;
