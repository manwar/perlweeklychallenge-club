#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 389 Task 2: ZigZag Subarray
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub zigzag_subarray( @nums ) {
    return scalar @nums if @nums <= 1;
    my ( $prev_num, $prev_dir, $count ) = ( $nums[0], 0, 1 );
    my $max = $count;
    for ( @nums[1..$#nums] ) {
        my $current_dir = $_ <=> $prev_num;
        $count =
            $current_dir == 0
                ? 1
            : ( $prev_dir != 0 && $current_dir != - $prev_dir )
                ? 2
                : $count + 1;
        ( $prev_num, $prev_dir ) = ( $_, $current_dir );
        $max = $count if $count > $max;
    }
    return $max;
}

use Test2::V0 qw( -no_srand );

my @tests = (
    [ "Example 1", [9, 4, 2, 10, 7, 8, 8, 1, 9], 5 ],
    [ "Example 2", [1, 7, 4, 9, 2, 5], 6 ],
    [ "Example 3", [1 .. 5], 2 ],
    [ "Example 4", [4, 4, 4], 1 ],
    [ "Example 5", [10, 20, 15, 12, 18], 3 ],
);

run( "zigzag_subarray", \@tests );
