#!/usr/bin/env perl

# Perl Weekly Challenge: Task 1 - Zero Friend
# Find the number closest to zero and return its distance to zero.

use strict;
use warnings;
use v5.30;

# Type definitions (using experimental Perl features for clarity)
use experimental 'signatures';

# Function to find the distance to zero of the closest number
sub zero_friend : prototype(@) (@nums) {

    # Return 0 if the input is empty
    return 0 unless @nums;

    # Find the minimum absolute value
    my $min_distance = abs( $nums[0] );
    for my $num (@nums) {
        my $distance = abs($num);
        $min_distance = $distance if $distance < $min_distance;
    }

    return $min_distance;
}

# Unit tests
use Test::More;

# Test cases from the problem
is( zero_friend( 4, 2, -1, 3, -2 ),     1, 'Test Case 1: (4, 2, -1, 3, -2) -> 1' );
is( zero_friend( -5, 5, -3, 3, -1, 1 ), 1, 'Test Case 2: (-5, 5, -3, 3, -1, 1) -> 1' );
is( zero_friend( 7, -3, 0, 2, -8 ),     0, 'Test Case 3: (7, -3, 0, 2, -8) -> 0' );
is( zero_friend( -2, -5, -1, -8 ),      1, 'Test Case 4: (-2, -5, -1, -8) -> 1' );
is( zero_friend( -2, 2, -4, 4, -1, 1 ), 1, 'Test Case 5: (-2, 2, -4, 4, -1, 1) -> 1' );

done_testing();
