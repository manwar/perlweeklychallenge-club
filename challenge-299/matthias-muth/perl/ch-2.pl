#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 299 Task 2: Word Search
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use builtin qw( true false );
no warnings 'experimental::builtin';

sub valid_neighbor_coords( $grid, $r, $c ) {
    return (
	$r > 0                ? ( $r - 1, $c ) : (),	
	$c > 0                ? ( $r, $c - 1 ) : (),	
	$c < $grid->[$r]->$#* ? ( $r, $c + 1 ) : (),	
	$r < $grid->$#*       ? ( $r + 1, $c ) : (),	
    );
}

sub word_search_at( $chars, $str, $r, $c, $visited ) {
    $visited->[$r][$c] = true;

    return true
	if $chars->[$r][$c] eq $str;

    return false
	if $chars->[$r][$c] ne substr( $str, 0, 1 );

    my $rest = substr( $str, 1 );
    for my ( $nr, $nc ) ( valid_neighbor_coords( $chars, $r, $c ) ) {
	return true
	    if ! $visited->[$nr][$nc]
		&& word_search_at( $chars, $rest, $nr, $nc, $visited );
    }

    return false;
}

sub word_search( $chars, $str ) {
    my @visited;
    for my $r ( keys $chars->@* ) {
	for my $c ( keys $chars->[$r]->@* ) {
	    return true
	        if word_search_at( $chars, $str, $r, $c, \@visited );
	}
    }
    return false;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

ok word_search( [
  ["A", "B", "D", "E"],
  ["C", "B", "C", "A"],
  ["B", "A", "A", "D"],
  ["D", "B", "B", "C"],
], "BDCA" ),
    'Example 1: word_search( [
  ["A", "B", "D", "E"],
  ["C", "B", "C", "A"],
  ["B", "A", "A", "D"],
  ["D", "B", "B", "C"],
], "BDCA" ) is true';
ok ! word_search( [
  ["A", "A", "B", "B"],
  ["C", "C", "B", "A"],
  ["C", "A", "A", "A"],
  ["B", "B", "B", "B"],
], "ABAC" ),
    'Example 2: word_search( [
  ["A", "A", "B", "B"],
  ["C", "C", "B", "A"],
  ["C", "A", "A", "A"],
  ["B", "B", "B", "B"],
], "ABAC" ) is false';
ok word_search( [
  ["B", "A", "B", "A"],
  ["C", "C", "C", "C"],
  ["A", "B", "A", "B"],
  ["B", "B", "A", "A"],
], "CCCAA" ),
    'Example 3: word_search( [
  ["B", "A", "B", "A"],
  ["C", "C", "C", "C"],
  ["A", "B", "A", "B"],
  ["B", "B", "A", "A"],
], "CCCAA" ) is true';

done_testing;
