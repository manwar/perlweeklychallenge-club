package SortOddEvenIndices;
use strict;
use warnings;
use Test::More;

sub sort_odd_even_indices {
    my @ints = @_;
    return @ints unless @ints;

    # Separate even and odd indices
    my @evens = @ints[ grep { $_ % 2 == 0 } 0 .. $#ints ];
    my @odds  = @ints[ grep { $_ % 2 == 1 } 0 .. $#ints ];

    # Sort them accordingly
    @evens = sort { $a <=> $b } @evens;
    @odds  = sort { $b <=> $a } @odds;

    # Reconstruct the array
    my @result;
    my ( $e, $o ) = ( 0, 0 );
    for my $i ( 0 .. $#ints ) {
        push @result, ( $i % 2 == 0 ) ? $evens[ $e++ ] : $odds[ $o++ ];
    }

    return @result;
}

# Unit tests
is_deeply(
    [ sort_odd_even_indices( 4, 1, 2, 3 ) ],
    [ 2, 3, 4, 1 ],
    'Example 1'
);

is_deeply( [ sort_odd_even_indices( 3, 1 ) ], [ 3, 1 ], 'Example 2' );

is_deeply(
    [ sort_odd_even_indices( 5, 3, 2, 1, 4 ) ],
    [ 2, 3, 4, 1, 5 ],
    'Example 3'
);

is_deeply( [ sort_odd_even_indices() ], [], 'Empty input' );

is_deeply( [ sort_odd_even_indices(5) ], [5], 'Single element' );

done_testing();
1;
