#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 224 Task 2: Additive Number
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( min );

sub additive_number {
    my ( $string ) = @_;
    vsay "additive_number( '$string' )";

    my $len = length $string;
    my $is_additive_number = 0;
    for my $len1 ( 1 .. int( ( $len - 1 ) / 2 ) ) {
	vsay "    len1: $len1, trying len2 1 .. min( ",
	    $len - 2 * $len1, ", ",
	    int( ( $len - $len1 ) / 2 ), " )";
	for my $len2 (
	    1 .. min( $len - 2 * $len1, int( ( $len - $len1 ) / 2 ) ) )
	{
	    my $n1 = substr $string, 0, $len1;
	    my $n2 = substr $string, $len1, $len2;
	    my $rest = substr $string, $len1 + $len2;
	    vsay "        trying $n1 and $n2, leaving '$rest'";
	    while ( $rest ne "" ) {
		my $sum = $n1 + $n2;
		$rest =~ s/^$sum// or do {
		    vsay "            no match for sum $sum";
		    last;
		};
		vsay "            sum $sum found";
		( $n1, $n2 ) = ( $n2, $sum );
	    }
	    if ( $rest eq "" ) {
		return 1
		    unless $verbose;
		vsay "            SUCCESS!";
		$is_additive_number = 1;
	    }
	}
    }
    return $is_additive_number;
}

run_tests;
