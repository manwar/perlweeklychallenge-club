#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 320 Task 1: Maximum Count
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub maximum_count_1( @ints ) {
    my ( $count_pos, $count_neg ) = ( 0, 0 );
    for ( @ints ) {
        if ( $_ > 0 ) {
            ++$count_pos
        }
        elsif ( $_ < 0 ) {
            ++$count_neg
        }
    }
    return $count_pos > $count_neg ? $count_pos : $count_neg;
}

use List::Util qw( max );

sub maximum_count_2( @ints ) {
    return max( scalar grep( $_ > 0, @ints ), scalar grep( $_ < 0, @ints ) );
}

*maximum_count = \&maximum_count_2;

use Test2::V0 qw( -no_srand );

is maximum_count( -3, -2, -1, 1, 2, 3 ), 3,
    'Example 1: maximum_count( -3, -2, -1, 1, 2, 3 ) == 3';
is maximum_count( -2, -1, 0, 0, 1 ), 2,
    'Example 2: maximum_count( -2, -1, 0, 0, 1 ) == 2';
is maximum_count( 1, 2, 3, 4 ), 4,
    'Example 3: maximum_count( 1, 2, 3, 4 ) == 4';

done_testing;

__END__

use Benchmark qw( :all );

my @ints = ( -3, -2, -1, 1, 2, 3 );

cmpthese -3 => {
    maximum_count_1 => sub { maximum_count_1( @ints ) },
    maximum_count_2 => sub { maximum_count_2( @ints ) },
};


