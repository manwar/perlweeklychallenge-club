#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 323 Task 2: Tax Amount
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use Dsay;

use List::Util qw( sum0 min reductions );

sub tax_amount( $income, $tax ) {
    my ( $tax_amount, $prev_bracket ) = ( 0, 0 );
    for ( $tax->@* ) {
	my ( $bracket, $percentage ) = $_->@*;
	last if $income <= $prev_bracket;
	my $bracketed_amount = $income < $bracket ? $income : $bracket;
	$tax_amount += ( $bracketed_amount - $prev_bracket ) * $percentage;
	$prev_bracket = $bracket;
    }
    return $tax_amount / 100;
}

sub tax_amount( $income, $tax ) {
    my @brackets =
	reductions { [ $a->[1], $b->[0], $b->[1] ] }
	    [ 0, 0, 0 ], $tax->@*;
    return sum0(
	map {
	    my ( $bracket_from, $bracket_to, $percentage ) = $_->@*;
	    $income > $bracket_from
	    ? $income < $bracket_to
		? ( $income     - $bracket_from ) * $percentage
		: ( $bracket_to - $bracket_from ) * $percentage
	    : 0;
	} @brackets
    ) / 100;
}

sub tax_amount( $income, $tax ) {
    my @brackets_from = ( 0, map( $_->[0], $tax->@* ) );
    my $tax_amount = 0;
    for ( keys $tax->@* ) {
	my ( $bracket_from, $bracket_to, $percentage ) =
	    ( $brackets_from[$_], $tax->[$_]->@* );
	last if $income <= $bracket_from;
	$tax_amount +=
	    $income < $bracket_to
	    ? ( $income     - $bracket_from ) * $percentage
	    : ( $bracket_to - $bracket_from ) * $percentage;
    }
    return $tax_amount / 100;
}

sub tax_amount( $income, $tax ) {
    my ( $tax_amount, $prev_bracket ) = ( 0, 0 );
    for ( $tax->@* ) {
	last if $income <= $prev_bracket;
	my ( $bracket, $percentage ) = $_->@*;
	my $bracketed_amount = $income < $bracket ? $income : $bracket;
	$tax_amount += ( $bracketed_amount - $prev_bracket ) * $percentage;
	$prev_bracket = $bracket;
    }
    return $tax_amount / 100;
}

use Test2::V0 qw( -no_srand );

is tax_amount( 10, [[3, 50], [7, 10], [12, 25]] ), 2.65,
    'Example 1: tax_amount( 10, [[3, 50], [7, 10], [12, 25]] ) == 2.65';
is tax_amount( 2, [[1, 0], [4, 25], [5, 50]] ), 0.25,
    'Example 2: tax_amount( 2, [[1, 0], [4, 25], [5, 50]] ) == 0.25';
is tax_amount( 0, [[2, 50]] ), 0,
    'Example 3: tax_amount( 0, [[2, 50]] ) == 0';

done_testing;
