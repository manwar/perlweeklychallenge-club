use strict;
use warnings;
use Test::More tests => 3;

sub minimum_swaps {
    my @ints = @_;
    my $n    = scalar @ints;
    my ( $pos1, $posn );

    # Find positions of 1 and n
    for my $i ( 0 .. $#ints ) {
        $pos1 = $i if $ints[$i] == 1;
        $posn = $i if $ints[$i] == $n;
    }

    my $total_swaps;
    if ( $pos1 < $posn ) {
        $total_swaps = $pos1 + ( $n - 1 - $posn );
    }
    else {
        $total_swaps = $pos1 + ( $n - 1 - $posn ) - 1;
    }

    return $total_swaps;
}

# Unit Tests

# Test Example 1
is( minimum_swaps( 2, 1, 4, 3 ), 2, 'Example 1' );

# Test Example 2
is( minimum_swaps( 2, 4, 1, 3 ), 3, 'Example 2' );

# Test Example 3
is( minimum_swaps( 1, 3, 2, 4, 5 ), 0, 'Example 3' );

done_testing();
