#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util qw(any sum);

sub main (@ints) {
    my $difference = 0;

    # Check we are only given positive integers
    if ( any { $_ < 0 } @ints ) {
        die "Only positive integers allowed";
    }

    foreach my $i (@ints) {
        # Single digit integers have no difference
        if ( $i > 9 ) {
            # Calculate the difference between the number and the sum of the
            #  individual digits
            $difference += $i - sum( split( //, $i ) );
        }
    }

    say abs($difference);
}

main(@ARGV);
