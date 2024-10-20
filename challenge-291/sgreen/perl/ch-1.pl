#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum0';

sub main (@ints) {
    foreach my $i (0 .. $#ints) {
        # See if the sum of the integers to the left of this position is the
        #  same as the remaining sum
        if (sum0(@ints[0 .. $i-1]) == sum0(@ints[$i + 1 .. $#ints])) {
            # It is, so return this position
            say $i;
            return;
        }
    }

    # No match found
    say -1;
}

main(@ARGV);