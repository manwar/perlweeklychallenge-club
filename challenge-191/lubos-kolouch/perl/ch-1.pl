#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub twice_largest {
    my (@list)    = @_;
    my $max       = -1;
    my $max_index = -1;

    # Find the largest element and its index
    for my $i ( 0 .. $#list ) {
        if ( $list[$i] > $max ) {
            $max       = $list[$i];
            $max_index = $i;
        }
    }

    # Check if the largest element is at least twice as large as each of the other items
    for my $i ( 0 .. $#list ) {
        if ( $i != $max_index && $list[$i] * 2 > $max ) {
            return -1;
        }
    }

    return 1;
}

is( twice_largest( 1, 2, 3, 4 ), -1, 'Example 1' );
is( twice_largest( 1, 2, 0, 5 ), 1,  'Example 2' );
is( twice_largest( 2, 6, 3, 1 ), 1,  'Example 3' );
is( twice_largest( 4, 5, 2, 3 ), -1, 'Example 4' );

done_testing();
