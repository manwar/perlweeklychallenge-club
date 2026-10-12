#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 394 Task 1: Alternate Case
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum min );

sub alternate_case( $str ) {
    # The approach follows this idea:
    # Focusing on the uppercase letters only, each one of them has to move
    # from its current position to the correct position in the final
    # alternate case string.
    # Every step is done by a swap, but we are only interested in the
    # *number* of swaps, which corresponds to the distance between the
    # initial position and the final position.
    # So first let's get the initial positions of all uppercase characters:
    my @uc_indices =
        grep { substr( $str, $_, 1 ) =~ /[A-Z]/ }
            0 .. length( $str ) - 1;
    # There are two types of alternate case strings:
    # * 'AbAbAb', starting with an uppercase letter, with all uppercase
    #   letters being on odd positions,
    # * 'aBaBaB', starting with a lower case letter, with all uppercase
    #   letters on even positions.
    # The lowest number of swaps can be with either of the two types as a
    # target type, so we need to calculate the number of necessary swaps
    # for both of them, and return the lower one.
    return min(
        sum( map {
                my $target_index = 2 * $_;
                abs( $target_index - $uc_indices[$_] );
            } keys @uc_indices ),
        sum( map {
                my $target_index = 2 * $_ + 1;
                abs( $target_index - $uc_indices[$_] );
            } keys @uc_indices ),
    );
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", "aAbB", 0 ],
    [ "Example 2", "AAbb", 1 ],
    [ "Example 3", "AAAbbb", 3 ],
    [ "Example 4", "aABb", 1 ],
    [ "Example 5", "bBBAaa", 2 ],
);

is alternate_case( $_->[1] ), $_->[2], $_->[0]
    for @tests;

done_testing;
