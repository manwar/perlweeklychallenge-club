#!/usr/bin/env perl

# Perl Weekly Challenge: Task 1 - Array Form Compute
# Add an integer to its array-form representation and return the resulting digits.

use strict;
use warnings;
use v5.30;

# Enable signatures for clearer intent.
use experimental 'signatures';

# Add the integer $x to the array-form integer represented by $digits_ref.
## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub array_form_compute ( $digits_ref, $x ) {
    my @digits = $digits_ref->@*;
    my @result;
    my $index = $#digits;
    my $carry = $x;

    while ( $index >= 0 || $carry > 0 ) {
        my $sum = $carry;
        if ( $index >= 0 ) {
            $sum += $digits[$index];
            $index--;
        }

        unshift @result, $sum % 10;
        $carry = int( $sum / 10 );
    }

    return @result ? @result : (0);
}

# Unit tests
use Test::More;

is_deeply(
    [ array_form_compute( [ 1, 2, 3, 4 ], 12 ) ],
    [ 1, 2, 4, 6 ],
    'Example 1: (1,2,3,4) + 12 -> (1,2,4,6)'
);
is_deeply( [ array_form_compute( [ 2, 7, 4 ], 181 ) ], [ 4, 5, 5 ], 'Example 2: (2,7,4) + 181 -> (4,5,5)' );
is_deeply( [ array_form_compute( [ 9, 9, 9 ], 1 ) ], [ 1, 0, 0, 0 ], 'Example 3: (9,9,9) + 1 -> (1,0,0,0)' );
is_deeply(
    [ array_form_compute( [ 1, 0, 0, 0, 0 ], 9999 ) ],
    [ 1, 9, 9, 9, 9 ],
    'Example 4: (1,0,0,0,0) + 9999 -> (1,9,9,9,9)'
);
is_deeply( [ array_form_compute( [0], 1000 ) ], [ 1, 0, 0, 0 ], 'Example 5: (0) + 1000 -> (1,0,0,0)' );

done_testing();
