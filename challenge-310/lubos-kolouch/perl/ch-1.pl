package ArraysIntersection;

use strict;
use warnings;
use Test::More;

sub arrays_intersection {
    my @arrays = @_;
    return () unless @arrays;

    # Start with first array as set
    my %common = map { $_ => 1 } @{ $arrays[0] };

    # Intersect with remaining arrays
    foreach my $arr ( @arrays[ 1 .. $#arrays ] ) {
        my %temp;
        @temp{@$arr} = ();
        foreach my $key ( keys %common ) {
            delete $common{$key} unless exists $temp{$key};
        }
    }

    my @sorted = sort { $a <=> $b } keys %common;
    return @sorted;
}

# Unit tests
is_deeply(
    [ arrays_intersection( [ 1, 2, 3, 4 ], [ 4, 5, 6, 1 ], [ 4, 2, 1, 3 ] ) ],
    [ 1, 4 ],
    'Example 1'
);

is_deeply( [ arrays_intersection( [ 1, 0, 2, 3 ], [ 2, 4, 5 ] ) ],
    [2], 'Example 2' );

is_deeply( [ arrays_intersection( [ 1, 2, 3 ], [ 4, 5 ], [6] ) ],
    [], 'Example 3' );

is_deeply( [ arrays_intersection() ], [], 'Empty input' );

is_deeply( [ arrays_intersection( [ 1, 2, 3 ] ) ], [ 1, 2, 3 ],
    'Single array' );

done_testing();

1;
