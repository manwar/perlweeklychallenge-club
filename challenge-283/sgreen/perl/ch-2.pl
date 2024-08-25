#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub main (@ints) {
    # Calculate the frequency of each integer
    my %freq = ();
    foreach my $int (@ints) {
        $freq{$int}++;
    }

    while ( my ( $idx, $value ) = each(@ints) ) {
        # Check the index only appear value number of times
        if ( ( $freq{$idx} // 0 ) != $value ) {
            say 'false';
            return;
        }
    }

    # Checks pass
    say 'true';

}

main(@ARGV);