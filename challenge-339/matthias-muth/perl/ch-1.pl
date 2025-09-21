#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 339 Task 1: Max Diff
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Dsay;

use List::Util qw( product max first );

sub max_diff( @ints ) {
    my @positives = sort { $b <=> $a } grep $_ >= 0, @ints;
    my @negatives = sort { $b <=> $a } grep $_ < 0, @ints;

    my @cases = (
        # Try the highest two positive numbers as the first product,
        # with the second product as small as possible after having used
        # those two positive numbers:
        @positives >= 2 ? do {
            my $pair_1 = [ @positives[0,1] ];
            @positives >= 3 && @negatives
                ? [ "case 1", $pair_1, [ $positives[2], $negatives[-1] ] ] : (),
            @positives >= 2 && @negatives >= 2
                ? [ "case 2", $pair_1, [ @negatives[0,1] ] ] : (),
            @negatives == 0
                ? [ "case 3", $pair_1, [ @positives[-2,-1] ] ] : (),
        } : (),

        # Try the lowest two negative numbers as the first product,
        # with the second product as small as possible after having used
        # those two negative numbers:
        @negatives >= 2 ? do {
            my $pair_1 = [ @negatives[-2,-1] ];
            @negatives >= 3 && @positives
                ? [ "case 4", $pair_1, [ $positives[0], $negatives[-3] ] ] : (),
            @positives >= 2
                ? [ "case 5", $pair_1, [ @positives[-2,-1] ] ] : (),
            @positives == 0
                ? [ "case 6", $pair_1, [ @negatives[0,1] ] ] : (),
        } : (),

        # Try a negative second product using the best possible 'mixed pair',
        # with the three options for the first product after that.
        # For the first product, we then have one less positive and
        # one less negative available.
        @negatives && @positives ? do {
            my $pair_2 = [ $positives[0], $negatives[-1] ];
            @positives >= 3
                ? [ "case 7", [ @positives[1,2] ], $pair_2 ] : (),
            @negatives >= 3
                ? [ "case 8", [ @negatives[-3,-2] ], $pair_2 ] : (),

            # In case we couldn't create either of the two cases above,
            # we have to use a 'mixed pair' for the first product:
            @negatives <= 2 && @positives <= 2
                ? [ "case 9", [ $positives[1], $negatives[-2] ], $pair_2 ] : (),
        } : (),
    );

    dsay pp @cases;
    my $maximum =
        max( map product( $_->[1]->@* ) - product( $_->[2]->@* ), @cases );

    return
        wantarray
        ? do {
            # Additional output for tests, debugging and documenting
            # (only if called in list context):
            # The first two pairs of numbers from @cases that result in
            # the maximum.
            ( $maximum,
                map $_->@[1,2],
                    first {
                        product( $_->[1]->@* ) - product( $_->[2]->@* )
                            == $maximum
                    } @cases
            )
        }
        : $maximum;
}

# Allow for including this script for the function definition
# (using 'require' or 'use'), but without executing the tests:
unless ( caller ) {

    use Test2::V0 qw( -no_srand );

    my @tests = (
        [ "Example 1", [ 5, 9, 3, 4, 6 ], 42 ],
        [ "Example 2", [ 1, -2, 3, -4 ], 10 ],
        [ "Example 3", [ -3, -1, -2, -4 ], 10 ],
        [ "Example 4", [ 10, 2, 0, 5, 1 ], 50 ],
        [ "Example 5", [ 7, 8, 9, 10, 10 ], 44 ],
    );

    for ( @tests ) {
        my ( $test_name, $input, $expected ) = $_->@*;
        my $descr = "$test_name:"
            . " max_diff( " . join( ", ", $input->@* ) . " ) == $expected";
        is max_diff( $input->@* ), $expected, $descr;
    }

    done_testing;
}
