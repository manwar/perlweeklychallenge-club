#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 294 Task 2: Next Permutation
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use Verbose;
$verbose = 1;

sub next_permutation( @ints ) {
    vsay "ints: @ints";
    return @ints
        if @ints <= 1;

    # Starting from the end, find the first number
    # that is lower than the one following it.
    my $index = $#ints;
    while( $index > 0 && $ints[ --$index ] gt $ints[ $index + 1 ] ) {
        # Everything is in the loop condition.
    }

    # No lower number found?
    # Then we are at the end of the permutations.
    if ( $index == 0 ) {
        vsay "index is 0";
        return reverse @ints;
    }
    my $value = $ints[$index];
    vsay "value to substitute: $value (at index $index)";

    # Find the next highest value within the right part,
    # for using it to replace the current value.
    # (Remember that maybe not all values in the right part are higher!)
    # It has to be higher than the one to substitute, but the
    # lowest possible one.
    my ( $index_2, $replacement ) = ( $index + 1, $ints[ $index + 1 ] );
    for ( $index_2 + 1 .. $#ints ) {
        ( $index_2, $replacement ) = ( $_, $ints[$_] )
            if $value lt $ints[$_] lt $replacement;
    }
    vsay "substitute value: $replacement (at index $index_2)";

    # Swap the two numbers.
    @ints[ $index, $index_2 ] = @ints[ $index_2, $index ];

    # We know that the right side is sorted, highest first.
    # to have it sorted lowest first, we just need to reverse it.
    @ints[ $index + 1 .. $#ints ] =
	reverse @ints[ $index + 1 .. $#ints ];

    vsay "result: @ints";
    return @ints;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ next_permutation( 1, 2, 3 ) ], [ 1, 3, 2 ],
    'Example 1: next_permutation( 1, 2, 3 ) == (1, 3, 2)';
is [ next_permutation( 2, 1, 3 ) ], [ 2, 3, 1 ],
    'Example 2: next_permutation( 2, 1, 3 ) == (2, 3, 1)';
is [ next_permutation( 3, 1, 2 ) ], [ 3, 2, 1 ],
    'Example 3: next_permutation( 3, 1, 2 ) == (3, 2, 1)';
is [ next_permutation( 3, 2, 1 ) ], [ 1, 2, 3 ],
    'Extra 1: next_permutation( 3, 2, 1 ) == (1, 2, 3)';
is [ next_permutation( qw( 1 4 5 3 2 ) ) ], [ qw( 1 5 2 3 4 ) ],
    'Extra 2: next_permutation( 1, 4, 5, 3, 2 ) == ( 1, 5, 2, 3, 4 )';
is [ next_permutation( qw( 1 4 3 7 9 8 6 5 2 ) ) ], [ qw( 1 4 3 8 2 5 6 7 9 ) ],
    'Extra 3: next_permutation( 1 4 3 7 9 8 6 5 2 ) == ( 1 4 3 8 2 5 6 7 9 )';
is [ next_permutation( qw( 1 4 3 7 9 10 8 6 5 2 ) ) ], [ qw( 1 4 3 7 9 2 10 5 6 8 ) ],
    'Extra 4: next_permutation( 1 4 3 7 9 10 8 6 5 2 ) == ( 1 4 3 7 9 2 10 5 6 8 )';
is [ next_permutation( qw( 41 40 4 31 30 3 21 20 2 11 10 1 ) ) ], [ qw( 1 10 11 2 20 21 3 30 31 4 40 41 ) ],
    'Extra 4: next_permutation( 40 4 30 3 20 2 10 1 ) == ( 1 10 2 20 3 30 4 40 )';
is [ next_permutation( 'a'..'z' ) ], [ 'a'..'x', 'z', 'y' ],
    "Extra 5: next_permutation( 'a'..'z' ) == ( 'a'..'x', 'z', 'y' )";

done_testing;
