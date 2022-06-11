package main;
use strict;
use warnings;

sub farey_sequence {
    my $n = shift;

    # I just adapted the Python algorithm from the wiki """

    my ( $a, $b, $c, $d ) = ( 0, 1, 1, $n );

    my @solution;

    push @solution, "$a/$b";
    while ( $c <= $n ) {
        my $k = int( ( $n + $b ) / $d );
        my ( $a, $b, $c, $d ) = ( $c, $d, $k * $c - $a, $k * $d - $b );
        push @solution, "$a/$b";
    }

    return join( ", ", @solution );
}

use Test::More;

is( farey_sequence(5),
    "0/1, 1/5, 1/4, 1/3, 2/5, 1/2, 3/5, 2/3, 3/4, 4/5, 1/1" );

done_testing;

1;
