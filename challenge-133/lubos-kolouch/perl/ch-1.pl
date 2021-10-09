use strict;
use warnings;

sub get_square_root {
    my ( $what, $low, $high ) = @_;

    $high //= $what;
    $low  //= 0;

    my $middle      = int( ( $high + $low ) / 2 );
    my $incr_middle = $middle + 1;

    # halve the interval

    if ( ( $middle * $middle <= $what ) and ( $incr_middle * $incr_middle >= $what ) ) {
        return $middle;
    }

    if ( $middle * $middle > $what ) {
        $middle = get_square_root( $what, $low, $middle );
    }
    else {
        $middle = get_square_root( $what, $middle, $high );
    }

    return $middle;
}

use Test::More;

is( get_square_root(10),  3 );
is( get_square_root(27),  5 );
is( get_square_root(85),  9 );
is( get_square_root(101), 10 );

done_testing;
