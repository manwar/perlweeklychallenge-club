use strict;
use warnings;

sub nth_root {
    my ( $n, $k ) = @_;
    return sprintf( "%.2f", $k**( 1 / $n ) );
}

print nth_root( 5, 248832 );    # Output: 12.00
print nth_root( 5, 34 );        # Output: 2.02
