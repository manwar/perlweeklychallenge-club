#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use List::Util 'any';

sub divmod( $a, $b ) {
    my $div = int( $a / $b );
    my $mod = $a % $b;
    return ( $div, $mod );
}

sub main (@ints) {
    # The last argument is $x
    my $x = pop @ints;
    my $remainder;

    # Check the list is single digit integers
    if ( any { $_ !~ /^[0-9]$/ } @ints ) {
        die "All elements in the list must be single digit integers (0-9).\n";
    }

    # Check x is a non-negative integer
    if ( $x < 0 ) {
        die "The integer x must be a non-negative integer.\n";
    }

    for ( my $pos = $#ints ; $pos > 0 ; $pos-- ) {
        my $i = $ints[$pos];

        # Split x into the carry forward and the last digit
        ( $x, $remainder ) = divmod( $x, 10 );

        # Add the remainder to the digit at the current position
        # However we may need to carry forward if the new digit is >= 10
        my ( $add_x, $add_i ) = divmod( $i + $remainder, 10 );
        $ints[$pos] = $add_i;
        $x += $add_x;
    }

    # Handle the most significant digit
    $ints[0] += $x;

    if ( $ints[0] >= 10 ) {
        # We need to split this into separate digits
        splice( @ints, 0, 1, split( //, $ints[0] ) );
    }

    say '(' . join( ', ', @ints ) . ')';
}

main(@ARGV);
