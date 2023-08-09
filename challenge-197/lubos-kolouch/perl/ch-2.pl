use strict;
use warnings;
use Test::More;
use Data::Dumper;

sub wiggle_sort {
    my @lst = @_;

    for my $i ( 1 .. @lst - 2 ) {
        if ( $i % 2 == 0 ) {

            # For even index, current element should be less than neighbors
            @lst[ $i, $i - 1 ] = @lst[ $i - 1, $i ] if $lst[$i] > $lst[ $i - 1 ];
            @lst[ $i, $i + 1 ] = @lst[ $i + 1, $i ] if $lst[$i] > $lst[ $i + 1 ];
        }
        else {
            # For odd index, current element should be greater than neighbors
            @lst[ $i, $i - 1 ] = @lst[ $i - 1, $i ] if $lst[$i] < $lst[ $i - 1 ];
            @lst[ $i, $i + 1 ] = @lst[ $i + 1, $i ] if $lst[$i] < $lst[ $i + 1 ];
        }
    }

    return @lst;
}

# Test Case 1
is_deeply( [ wiggle_sort( 1, 5, 1, 1, 6, 4 ) ], [ 1, 5, 1, 6, 1, 4 ], "Test Case 1" );

# Test Case 2
is_deeply( [ wiggle_sort( 1, 3, 2, 2, 3, 1 ) ], [ 1, 3, 2, 3, 1, 2 ], "Test Case 2" );

done_testing();
