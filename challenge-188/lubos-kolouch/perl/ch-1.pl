#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub divisible_pairs {
    my ( $list, $k ) = @_;
    my $count = 0;

    for my $i ( 0 .. $#$list - 1 ) {
        for my $j ( $i + 1 .. $#$list ) {
            $count++ if ( $list->[$i] + $list->[$j] ) % $k == 0;
        }
    }
    return $count;
}

is( divisible_pairs( [ 4, 5, 1, 6 ], 2 ), 2, 'Example 1' );
is( divisible_pairs( [ 1, 2, 3, 4 ], 2 ), 2, 'Example 2' );
is( divisible_pairs( [ 1, 3, 4, 5 ], 3 ), 2, 'Example 3' );
is( divisible_pairs( [ 5, 1, 2, 3 ], 4 ), 2, 'Example 4' );
is( divisible_pairs( [ 7, 2, 4, 5 ], 4 ), 1, 'Example 5' );

done_testing();
