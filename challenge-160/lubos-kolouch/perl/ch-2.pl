package main;
use strict;
use warnings;
use List::Util qw/sum/;

sub get_eq_index {
    my @what = @_;

    my $elem_count = scalar @what;

    for my $i ( 1 .. $elem_count - 2 ) {
        if ( sum( @what[ 0 .. $i - 1 ] )
            == sum( @what[ $i + 1 .. $elem_count - 1 ] ) )
        {
            return $i;
        }
    }

    return -1;
}

use Test::More;
is( get_eq_index( 1, 3, 5, 7, 9 ), 3,  'Test 1 3 5 7 9' );
is( get_eq_index( 1, 2, 3, 4, 5 ), -1, 'Test 1 2 3 4 5 ' );
is( get_eq_index( 2, 4, 2 ), 1, 'Test 2 4 2' );

is( get_eq_index(2), -1, 'Test 2' );
done_testing;
1;
