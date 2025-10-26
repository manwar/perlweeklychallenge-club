#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 344 Task 1: Array Form Compute
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub array_form_compute( $ints, $x ) {

    # Split $x into its digits.
    my @add_digits = split "", $x;

    # Start with the last digit in the array.
    my $index = $ints->$#*;
    while ( @add_digits && $index >= 0 ) {
        # Add the last digit of @add_digits to the current array digit,
        # removing it from @add_digits at the same time.
        $ints->[$index] += pop @add_digits;

        # Check and correct a carryover from the sum of the two digits.
        # Recreate an entry in @add_digits for that carryover if needed
        # (if @add_digits is empty).
        if ( $ints->[$index] >= 10 ) {
            $ints->[$index] -= 10;
            @add_digits ? ( $add_digits[-1] += 1 ) : ( $add_digits[0] = 1 );
        }

        --$index;
    }

    # If there still are any digits left in $add_digits, they are prepended to
    # the existing array digits.
    return ( @add_digits, $ints->@* );
}

use Test2::V0 qw( -no_srand );

is [ array_form_compute( [1 .. 4], 12 ) ], [ 1, 2, 4, 6 ],
    'Example 1: array_form_compute( [1 .. 4], 12 ) == (1, 2, 4, 6)';
is [ array_form_compute( [2, 7, 4], 181 ) ], [ 4, 5, 5 ],
    'Example 2: array_form_compute( [2, 7, 4], 181 ) == (4, 5, 5)';
is [ array_form_compute( [9, 9, 9], 1 ) ], [ 1, 0, 0, 0 ],
    'Example 3: array_form_compute( [9, 9, 9], 1 ) == (1, 0, 0, 0)';
is [ array_form_compute( [1, 0, 0, 0, 0], 9999 ) ], [ 1, 9, 9, 9, 9 ],
    'Example 4: array_form_compute( [1, 0, 0, 0, 0], 9999 ) == (1, 9, 9, 9, 9)';
is [ array_form_compute( [0], 1000 ) ], [ 1, 0, 0, 0 ],
    'Example 5: array_form_compute( [0], 1000 ) == (1, 0, 0, 0)';

is [ array_form_compute( [ ( 9 ) x 20 ], 1 ) ],
    [ 1, ( 0 ) x 20 ],
    "Own Example 1: twenty digits of all nines plus 1";

is [ array_form_compute( [ 1 ], ~0 ) ],
    [ split "", "18446744073709551616" ],
    "Own Example 2: ( 1 ) plus 2^64-1";

done_testing;
