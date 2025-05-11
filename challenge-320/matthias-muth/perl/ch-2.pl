#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 320 Task 2: Sum Difference
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( sum );

sub sum_difference_1( @ints ) {
    return abs( sum( map sum( split "", $_ ), @ints ) - sum( @ints ) );
}

sub sum_difference_2( @ints ) {
    return abs( sum( map split( "", $_ ), @ints ) - sum( @ints ) );
}

sub sum_difference_3( @ints ) {
    return abs( sum( split "", join "", @ints ) - sum( @ints ) );
}

*sum_difference = \&sum_difference_3;

use Test2::V0 qw( -no_srand );

is sum_difference( 1, 23, 4, 5 ), 18,
    'Example 1: sum_difference( 1, 23, 4, 5 ) == 18';
is sum_difference( 1, 2, 3, 4, 5 ), 0,
    'Example 2: sum_difference( 1, 2, 3, 4, 5 ) == 0';
is sum_difference( 1, 2, 34 ), 27,
    'Example 3: sum_difference( 1, 2, 34 ) == 27';

done_testing;

__END__

use Benchmark qw( :all );

my @ints = ( 1, 23, 4, 5 );

cmpthese -3 => {
    sum_difference_1 => sub { sum_difference_1( @ints ) },
    sum_difference_2 => sub { sum_difference_2( @ints ) },
    sum_difference_3 => sub { sum_difference_3( @ints ) },
};


