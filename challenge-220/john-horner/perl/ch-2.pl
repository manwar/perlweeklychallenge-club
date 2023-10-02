use v5.10;
use strict;
use warnings;

my @ints = ( 2, 7, 4, 1, 8, 1, 8 );

my @sorted_ints = reverse sort @ints;

while ( scalar(@sorted_ints) > 1 ) {
    @sorted_ints = reverse sort @sorted_ints;
    my ( $x, $y ) = splice( @sorted_ints, 0, 2 );
    push( @sorted_ints, $x - $y ) if $x != $y;
}
say( scalar(@sorted_ints) == 1 ? @sorted_ints : 0 );
