#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 210 Task 2: Number Collision
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;

use List::Util qw( all );

sub number_collision {
    my ( @list ) = @_;

    while ( ( ! all { $_ > 0 } @list )
        && ! all { $_ < 0 } @list )
    {
        for ( 0 .. $#list - 1 ) {
            if ( ( $list[$_] <=> 0 ) != ( $list[ $_ + 1 ] <=> 0 ) ) {
                # Kill the left one if its value is less or equal.
                my $pos =
                    abs( $list[$_] ) <= abs( $list[ $_ + 1 ] )
                    ? $_
                    : $_ + 1 ;
                # Kill both if their values are equal.
                my $n =
                    abs( $list[$_] ) == abs( $list[ $_ + 1 ] )
                    ? 2
                    : 1;
                splice @list, $pos, $n, ();
                last;
            }
        }
    }

    return @list;
}

use Test::More;

do {
    is_deeply [ number_collision( @{$_->{INPUT}} ) ], $_->{EXPECTED},
        "number_collision(" . join( ",", @{$_->{INPUT}} ) . ") == "
        . ( "(" . join( ",", @{$_->{EXPECTED}} ) . ")" );
} for (
    { INPUT => [ 2,3,-1 ], EXPECTED => [ 2,3 ] },
    { INPUT => [ 3,2,-4 ], EXPECTED => [ -4 ]},
    { INPUT => [ 1,-1 ], EXPECTED => [] },
);

done_testing;
