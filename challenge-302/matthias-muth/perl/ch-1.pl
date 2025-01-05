#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 302 Task 1: Ones and Zeroes
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Algorithm::Combinatorics qw( subsets );

sub ones_and_zeroes( $str, $x, $y ) {

    my @counts = map {
	my @count = ( 0, 0 );
	++$count[$_]
	    for split "", $_;
	\@count;
    } $str->@*;

    my $max = 0;
    my $iter = subsets( \@counts );
    while ( my $subset = $iter->next ) {
	my @sum = ( 0, 0 );
	for ( $subset->@* ) {
	    $sum[0] += $_->[0];
	    $sum[1] += $_->[1];
	}
	$max = scalar $subset->@*
	    if $sum[0] <= $x && $sum[1] <= $y && scalar $subset->@* > $max;
    }
    return $max;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is ones_and_zeroes( [10, "0001", 111001, 1, 0], 5, 3 ), 4,
    'Example 1: ones_and_zeroes( [10, "0001", 111001, 1, 0], 5, 3 ) == 4';
is ones_and_zeroes( [10, 1, 0], 1, 1 ), 2,
    'Example 2: ones_and_zeroes( [10, 1, 0], 1, 1 ) == 2';

done_testing;
