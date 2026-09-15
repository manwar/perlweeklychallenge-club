#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';
use List::Util qw(max);

# Task 2: Nested Boxes
# Determine the maximum number of boxes that can fit inside each other in a single stack.
# For box A to fit inside box B: A[0] < B[0] and A[1] < B[1].

sub max_nested_boxes (@boxes) {
    return 0 if !@boxes;

    # Sort boxes:
    # 1. Width ascending
    # 2. Height descending for same width (prevents nesting boxes of identical width)
    my @sorted = sort {
        $a->[0] <=> $b->[0] || $b->[1] <=> $a->[1]
    } @boxes;

    # Longest Increasing Subsequence (LIS) on heights using patience sorting / binary search: O(N log N)
    my @tails;

    for my $box (@sorted) {
        my $h = $box->[1];

        # Binary search for the first element in @tails >= $h
        my $left  = 0;
        my $right = scalar @tails;

        while ( $left < $right ) {
            my $mid = int( ( $left + $right ) / 2 );
            if ( $tails[$mid] >= $h ) {
                $right = $mid;
            }
            else {
                $left = $mid + 1;
            }
        }

        if ( $left == scalar @tails ) {
            push @tails, $h;
        }
        else {
            $tails[$left] = $h;
        }
    }

    return scalar @tails;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( max_nested_boxes( [ 1, 3 ], [ 3, 5 ], [ 6, 8 ], [ 2, 4 ] ), 4, 'Example 1' );
    is( max_nested_boxes( [ 4, 5 ], [ 4, 6 ], [ 6, 7 ], [ 2, 3 ], [ 4, 3 ] ), 3, 'Example 2' );
    is( max_nested_boxes( [ 5, 5 ], [ 5, 5 ], [ 5, 5 ] ), 1, 'Example 3' );
    is( max_nested_boxes( [ 2, 100 ], [ 3, 200 ], [ 4, 300 ], [ 5, 50 ], [ 5, 400 ] ), 4, 'Example 4' );
    is( max_nested_boxes( [ 10, 20 ], [ 15, 10 ], [ 20, 30 ], [ 12, 18 ], [ 16, 25 ] ), 3, 'Example 5' );

    done_testing();
}
else {
    say "Run via embedded tests.";
}
