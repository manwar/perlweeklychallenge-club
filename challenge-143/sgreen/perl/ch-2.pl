#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use List::Util 'any';

sub main {
    my $n  = shift;
    my @ab = ();

    # Find all possible values of ab (or cd)
    foreach my $i ( 1 .. sqrt($n) ) {
        if ( $n % $i == 0 ) {
            # We found one
            my $this_ab = $i + $n / $i;

            # Check if it is one less/more than any other values
            if ( any { abs( $this_ab - $_ ) == 1 } @ab ) {
                say '1';
                return;
            }

            # Add this value to be checked later
            push @ab, $this_ab;
        }
    }

    say '0';
}

main(@ARGV);
