use strict;
use warnings;
use Test::More;

sub pattern_132 {
    my @list = @_;
    my $n    = scalar @list;

    # Iterate through the list and try to find the pattern
    for my $i ( 0 .. $n - 3 ) {
        for my $j ( $i + 1 .. $n - 2 ) {
            for my $k ( $j + 1 .. $n - 1 ) {
                if ( $list[$i] < $list[$k] && $list[$k] < $list[$j] ) {
                    return ( $list[$i], $list[$j], $list[$k] );
                }
            }
        }
    }

    return ();
}

# Test cases
is_deeply( [ pattern_132( 3, 1, 4, 2 ) ],       [ 1, 4, 2 ], 'Example 1' );
is_deeply( [ pattern_132( 1, 2, 3, 4 ) ],       [],          'Example 2' );
is_deeply( [ pattern_132( 1, 3, 2, 4, 6, 5 ) ], [ 1, 3, 2 ], 'Example 3' );
is_deeply( [ pattern_132( 1, 3, 4, 2 ) ],       [ 1, 3, 2 ], 'Example 4' );

done_testing();
