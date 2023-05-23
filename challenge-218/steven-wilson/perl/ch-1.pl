#!/usr/bin/env perl
# You are given a list of 3 or more integers.
# Write a script to find the 3 integers whose product is the maximum and return it.

use strict;
use warnings;
use Test::More;
use List::Util qw/ product /;

ok( max_product( 3,  1, 2 ) == 6 );
ok( max_product( 4,  1, 3, 2 ) == 24 );
ok( max_product( -1, 0, 1, 3, 1 ) == 3 );
ok( max_product( -8, 2, -9, 0, -4, 3 ) == 216 );
done_testing();

sub max_product {
    my @sorted_list = sort { $a <=> $b } @_;
    my $max_last    = product( @sorted_list[ -3 .. -1 ] );
    my $max_first   = product( @sorted_list[ 0, 1, -1 ] );
    $max_first > $max_last ? return $max_first : return $max_last;
}
