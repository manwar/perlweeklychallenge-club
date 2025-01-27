#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

# Function to find maximum average of contiguous subarray
sub find_max_average {
    my ( $nums_ref, $n ) = @_;

    die "Invalid input: n must be <= length of nums and nums must not be empty"
      if !@$nums_ref || $n > scalar(@$nums_ref);

    # Calculate initial window sum
    my $window_sum = 0;
    $window_sum += $_ for @$nums_ref[ 0 .. ( $n - 1 ) ];
    my $max_sum = $window_sum;

    # Slide the window and update max_sum
    for my $i ( $n .. scalar(@$nums_ref) - 1 ) {
        $window_sum = $window_sum + $nums_ref->[$i] - $nums_ref->[ $i - $n ];
        $max_sum    = $window_sum if $window_sum > $max_sum;
    }

    return $max_sum / $n;
}

# Tests
subtest 'Example cases' => sub {
    is( find_max_average( [ 1, 12, -5, -6, 50, 3 ], 4 ),
        12.75, 'Example 1 works' );
    is( find_max_average( [5], 1 ), 5, 'Example 2 works' );
};

subtest 'Edge cases' => sub {
    is( find_max_average( [ 1, 2, 3 ], 3 ), 2, 'Full array works' );
    eval { find_max_average( [], 1 ) };
    like( $@, qr/Invalid input/, 'Empty array throws error' );
    eval { find_max_average( [ 1, 2 ], 3 ) };
    like( $@, qr/Invalid input/, 'n > length throws error' );
};

subtest 'Additional cases' => sub {
    is( find_max_average( [ -1, -2, -3, -4 ], 2 ),
        -1.5, 'Negative numbers work' );
    is( find_max_average( [ 1, 2, 3, 4, 5 ], 2 ), 4.5, 'Decimal result works' );
};

done_testing();
