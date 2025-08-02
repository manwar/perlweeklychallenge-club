#!/usr/bin/env perl

use strict;
use warnings;
use feature qw(bitwise say);
use experimental 'signatures';

sub main (@encoded) {
    # Start with the initial value
    my @orig = (pop(@encoded));

    foreach my $i (@encoded) {
        # Add this value XORed with the last value in the list
        push @orig, ($i ^ $orig[-1]);
    }

    say join ', ', @orig;
}

main(@ARGV);
