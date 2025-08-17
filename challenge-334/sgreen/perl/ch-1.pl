#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'sum';

sub main (@ints) {
    my $y = pop @ints;    # Last element is y
    my $x = pop @ints;    # Second last element is x

    # Sanity checks for x and y
    if ( $x < 0 or $x > $#ints ) {
        die "x must be between 0 and " . $#ints . ", got $x\n";
    }
    if ( $y < 0 or $y > $#ints ) {
        die "y must be between 0 and " . $#ints . ", got $y\n";
    }
    if ( $x > $y ) {
        die "x must be less than or equal to y, got x=$x, y=$y\n";
    }

    # Return the sum of the range from x to y (inclusive)
    say sum( @ints[ $x .. $y ] );
}

main(@ARGV);
