#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 351 Task 1: Special Average
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::MoreUtils qw( minmax );
use List::Util qw( sum0 );

sub special_average( @ints ) {
    my ( $min, $max ) = minmax @ints;
    my @stripped = grep $min < $_ < $max, @ints;
    return sum0( @stripped ) / ( scalar @stripped || 1 );
}

sub special_average( @ints ) {
    @ints = sort { $a <=> $b } @ints;
    return sum0( @ints[ 1 .. $#ints - 1 ] ) / ( ( @ints - 2 ) || 1 );
}

use Test2::V0 qw( -no_srand );

is special_average( 8000, 5000, 6000, 2000, 3000, 7000 ), 5250,
    'Example 1: special_average( 8000, 5000, 6000, 2000, 3000, 7000 ) == 5250';
is special_average( 100000, 80000, 110000, 90000 ), 95000,
    'Example 2: special_average( 100000, 80000, 110000, 90000 ) == 95000';
is special_average( 2500, 2500, 2500, 2500 ), 0,
    'Example 3: special_average( 2500, 2500, 2500, 2500 ) == 0';
is special_average( 2000 ), 0,
    'Example 4: special_average( 2000 ) == 0';
is special_average( 1000, 2000, 3000, 4000, 5000, 6000 ), 3500,
    'Example 5: special_average( 1000, 2000, 3000, 4000, 5000, 6000 ) == 3500';
is special_average( 10, 20 ), 0,
    'Test 1: special_average( 10, 20 ) == 0';

done_testing;
