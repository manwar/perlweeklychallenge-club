use strict;
use warnings;

sub nth_root {
    my ( $n, $k ) = @_;
    my $s = sprintf( "%.2f", $k**( 1 / $n ) );
    $s =~ s/\.?0+$//;
    return $s;
}

use Test::More;

is( nth_root( 5, 248832 ), '12',   'Example 1' );
is( nth_root( 5, 34 ),     '2.02', 'Example 2' );

done_testing;
