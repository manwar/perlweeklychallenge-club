#https://theweeklychallenge.org/blog/perl-weekly-challenge-293/

use strict; use warnings;

sub is_boomerang {
    my %h;
    @h{
        map {
            my($dx, $dy) = ( $_[ $_ ][ 0 ] - $_[ $_ - 1 ][ 0 ],
                             $_[ $_ ][ 1 ] - $_[ $_ - 1 ][ 1 ] );
            $dy != 0 ? $dx / $dy : "inf"
        }
        1 .. $#_
    } = ();
    1 < keys %h
}

use Test::More;
my( $true, $false ) = ( 1, '' );
is is_boomerang( [1, 1], [2, 3], [3,2] )  => $true;
is is_boomerang( [1, 1], [2, 2], [3, 3] ) => $false;
is is_boomerang( [1, 1], [1, 2], [2, 3] ) => $true;
is is_boomerang( [1, 1], [1, 2], [1, 3] ) => $false;
is is_boomerang( [1, 1], [2, 1], [3, 1] ) => $false;
is is_boomerang( [0, 0], [2, 3], [4, 5] ) => $true;
done_testing;
