#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

sub same_digits {
    my ( $x, $b ) = @_;

    # Record the digit
    my $d = undef;

    while ( $x != 0 ) {
        my $this_digit = $x % $b;
        if ( not defined $d ) {
            # First (right most) digit
            $d = $this_digit;
        }
        elsif ( $d != $this_digit ) {
            # Check this digit matches the other one
            return 0;
        }

        # Divide x by the b allows us to calculate the next right most digit
        $x = int( $x / $b );
    }

    return 1;
}

sub main {
    # Convert string to integer
    my $n = shift;

    # Calculate for bases 2 to n-2
    foreach my $b ( 2 .. $n - 2 ) {
        # Check for n in base b is all the same digits
        if ( same_digits( $n, $b ) ) {
            say "1 (base $b)";
            return;
        }
    }

    # Not a brazilian number
    say 0;
}

main(@ARGV);