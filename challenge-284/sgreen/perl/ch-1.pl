#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Calculate the frequency of each integer
    my %freq = ();
    foreach my $i (@ints) {
        ++$freq{$i};
    }

    # Work through the dict, highest first
    foreach my $i ( sort { $b <=> $a } keys %freq ) {
        if ( $i == $freq{$i} ) {
            # We have the lucky integer
            say $i;
            return;
        }
    }

    # There is no lucky integer
    say -1;
}

main(@ARGV);