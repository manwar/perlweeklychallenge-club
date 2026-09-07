#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: ZigZag Subarray
# Find the length of the longest contiguous subarray where the numbers
# alternate between strictly increasing and strictly decreasing.

sub longest_zigzag_subarray (@nums) {
    my $n = scalar @nums;
    return 0 if $n == 0;
    return 1 if $n == 1;

    my $max_len   = 1;
    my $curr_len  = 1;
    my $last_diff = 0;

    for my $i ( 1 .. $#nums ) {
        my $diff = $nums[$i] <=> $nums[ $i - 1 ];

        if ( $diff == 0 ) {
            $curr_len  = 1;
            $last_diff = 0;
        }
        elsif ( $last_diff == 0 || $diff == -$last_diff ) {
            $curr_len++;
            $last_diff = $diff;
        }
        else {
            # Same direction twice in a row (e.g. up-up or down-down)
            $curr_len  = 2;
            $last_diff = $diff;
        }

        $max_len = $curr_len if $curr_len > $max_len;
    }

    return $max_len;
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    is( longest_zigzag_subarray( 9, 4, 2, 10, 7, 8, 8, 1, 9 ), 5, 'Example 1' );
    is( longest_zigzag_subarray( 1, 7, 4, 9, 2, 5 ),           6, 'Example 2' );
    is( longest_zigzag_subarray( 1, 2, 3, 4, 5 ),              2, 'Example 3' );
    is( longest_zigzag_subarray( 4, 4, 4 ),                    1, 'Example 4' );
    is( longest_zigzag_subarray( 10, 20, 15, 12, 18 ),         3, 'Example 5' );

    is( longest_zigzag_subarray( 5 ),                          1, 'Single element' );
    is( longest_zigzag_subarray(),                             0, 'Empty array' );
    is( longest_zigzag_subarray( 5, 5 ),                       1, 'Two equal elements' );

    done_testing();
}
else {
    say longest_zigzag_subarray(@ARGV);
}
