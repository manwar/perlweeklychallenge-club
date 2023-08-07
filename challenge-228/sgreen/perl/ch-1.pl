#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum0';

sub main (@ints) {
    # Get the frequency of all numbers
    my %freq = ();
    foreach my $i (@ints) {
        ++$freq{$i};
    }

    # Get the sum of all unique values
    my $solution = sum0( grep { $freq{$_} == 1 } keys %freq );
    say $solution;
}

main(@ARGV);