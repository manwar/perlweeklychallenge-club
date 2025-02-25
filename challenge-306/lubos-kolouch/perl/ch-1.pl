use strict;
use warnings;

=head2 odd_sum

Calculate the sum of all possible odd-length subarrays of the given array.

A subarray is a contiguous subsequence of the array. This function computes the sum of each element of every possible subarray with odd length and returns the total sum.

@param @ints Array of positive integers.

@return The sum of all odd-length subarrays.

=cut

sub odd_sum {
    my @ints   = @_;
    my $n      = scalar @ints;
    my @prefix = (0);
    for my $i ( 0 .. $n - 1 ) {
        $prefix[ $i + 1 ] = $prefix[$i] + $ints[$i];
    }
    my $total = 0;
    for ( my $l = 1 ; $l <= $n ; $l += 2 ) {
        my $max_start = $n - $l;
        for ( my $start = 0 ; $start <= $max_start ; $start++ ) {
            my $end = $start + $l;
            $total += $prefix[$end] - $prefix[$start];
        }
    }
    return $total;
}

# Tests
use Test::More tests => 4;

is( odd_sum( 2, 5, 3, 6, 4 ), 77,                    'Example 1' );
is( odd_sum( 1, 3 ),          4,                     'Example 2' );
is( odd_sum(5),               5,                     'Single element' );
is( odd_sum( 1, 2, 3 ),       1 + 2 + 3 + 1 + 2 + 3, 'Length 3 array' );

done_testing();
