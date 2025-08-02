use strict;
use warnings;
use Test::More tests => 7;

sub find_max_length {
    my @binary = @_;
    my @mapped = map { $_ == 0 ? -1 : 1 } @binary;
    my %sum_indices;
    my $max_length     = 0;
    my $cumulative_sum = 0;

    for my $i ( 0 .. $#mapped ) {
        $cumulative_sum += $mapped[$i];

        if ( $cumulative_sum == 0 ) {

            # Subarray from index 0 to i has equal number of 0s and 1s
            $max_length = $i + 1;
        }
        if ( exists $sum_indices{$cumulative_sum} ) {

            # Found a subarray with equal number of 0s and 1s
            my $length = $i - $sum_indices{$cumulative_sum};
            if ( $length > $max_length ) {
                $max_length = $length;
            }
        }
        else {
            # Store the first occurrence of this cumulative sum
            $sum_indices{$cumulative_sum} = $i;
        }
    }
    return $max_length;
}

# Unit Tests

# Test Example 1
is( find_max_length( 1, 0 ), 2, 'Example 1' );

# Test Example 2
is( find_max_length( 0, 1, 0 ), 2, 'Example 2' );

# Test Example 3
is( find_max_length( 0, 0, 0, 0, 0 ), 0, 'Example 3' );

# Test Example 4
is( find_max_length( 0, 1, 0, 0, 1, 0 ), 4, 'Example 4' );

# Test Empty Input
is( find_max_length(), 0, 'Empty Input' );

# Test No Equal Subarray
is( find_max_length( 0, 0, 0, 1, 1 ), 4, 'No Equal Subarray' );

# Test Long Array
my @binary = ( 0, 1 ) x 1000;    # 2000 elements
is( find_max_length(@binary), 2000, 'Long Array' );

1;
