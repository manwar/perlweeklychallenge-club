use strict;
use warnings;
use List::Util qw/min/;

sub get_min_count {
    my @in_arr = @_;

    my $min_sum = 0;

    for my $sub_arr (@in_arr) {

        # so obviously it is not a tree, just independent arrays
        # so I can just take a min from each row

        $min_sum += min(@$sub_arr);
    }

    return $min_sum;
}

use Test::More;

is( get_min_count( [1], [ 5, 3 ], [ 2, 3, 4 ], [ 7, 1, 0, 2 ], [ 6, 4, 5, 2, 8 ] ), 8 );
is( get_min_count( [5], [ 2, 3 ], [ 4, 1, 5 ], [ 0, 1, 2, 3 ], [ 7, 2, 4, 1, 9 ] ), 9 );

done_testing;
