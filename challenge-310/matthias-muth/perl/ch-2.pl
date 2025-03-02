#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 310 Task 2: Sort Odd Even
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use List::Util qw( mesh );

sub sort_odd_even_mesh( @ints ) {
    my @even = sort { $a <=> $b } @ints[ grep $_ % 2 == 0,  keys @ints ];
    my @odd  = sort { $b <=> $a } @ints[ grep $_ % 2 != 0,  keys @ints ];
    return ( mesh \@even, \@odd )[ keys @ints ];
}

sub sort_odd_even( @ints ) {
    my @even = sort { $a <=> $b } @ints[ grep $_ % 2 == 0,  keys @ints ];
    my @odd  = sort { $b <=> $a } @ints[ grep $_ % 2 != 0,  keys @ints ];
    return
	map( { $even[$_], $odd[$_] } keys @odd ),
	@even > @odd ? $even[-1] : ();
}

=for benchmark

sub sort_odd_even_possibly_faster( @ints ) {
    my @even = sort { $a <=> $b } @ints[ map $_ * 2    , 0 .. ( $#ints / 2 ) ];
    my @odd  = sort { $b <=> $a } @ints[ map $_ * 2 - 1, 1 .. ( @ints  / 2 ) ];
    return
	map( { $even[$_], $odd[$_] } keys @odd ),
	@even > @odd ? $even[-1] : ();
}

use Benchmark qw( :all );

my @ints = ( 5, 3, 2, 1, 4 ) x 100;
cmpthese( -3 => {
    sort_odd_even_1 => sub { sort_odd_even_1( @ints ) },
    sort_odd_even_2 => sub { sort_odd_even_2( @ints ) },
} );

exit 0;

=cut

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ sort_odd_even( 4, 1, 2, 3 ) ], [ 2, 3, 4, 1 ],
    'Example 1: sort_odd_even( 4, 1, 2, 3 ) == (2, 3, 4, 1)';
is [ sort_odd_even( 3, 1 ) ], [ 3, 1 ],
    'Example 2: sort_odd_even( 3, 1 ) == (3, 1)';
is [ sort_odd_even( 5, 3, 2, 1, 4 ) ], [ 2, 3, 4, 1, 5 ],
    'Example 3: sort_odd_even( 5, 3, 2, 1, 4 ) == (2, 3, 4, 1, 5)';

done_testing;
