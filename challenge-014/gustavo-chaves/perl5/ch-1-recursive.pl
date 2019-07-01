#!/usr/bin/env perl

# Write a script to generate Van Eck’s sequence starts with 0. For more
# information, please check out wikipedia page
# (https://en.wikipedia.org/wiki/Van_Eck%27s_sequence). This challenge was
# proposed by team member Andrezgz.

# This is a recursive implementation.

use 5.026;
use strict;
use warnings;
use Memoize;

my $sequence_size = shift or die "Usage: $0 SIZE\n";

memoize('van_ecks');
sub van_ecks {
    my ($n) = @_;

    return 0 if $n <= 1;

    my $previous_value = van_ecks($n-1);

    for (my $i=$n-2; $i >= 0; --$i) {
        if (van_ecks($i) == $previous_value) {
            return ($n-1) - $i;
        }
    }

    return 0;
}

for my $i (0 .. $sequence_size-1) {
    say van_ecks($i);
}
