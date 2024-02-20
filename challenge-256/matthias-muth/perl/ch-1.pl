#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 256 Task 1: Maximum Pairs
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub maximum_pairs( @words ) {
    my $n = 0;
    my %known;
    for ( @words ) {
        ++$n if $known{ reverse $_ };
	$known{$_} = 1;
    }
    return $n;
}

use Test2::V0 qw( -no_srand );
is maximum_pairs( "ab", "de", "ed", "bc" ), 1,
    'Example 1: maximum_pairs( ("ab", "de", "ed", "bc") ) == 1';
is maximum_pairs( "aa", "ba", "cd", "ed" ), 0,
    'Example 2: maximum_pairs( ("aa", "ba", "cd", "ed") ) == 0';
is maximum_pairs( "uv", "qp", "st", "vu", "mn", "pq" ), 2,
    'Example 3: maximum_pairs( ("uv", "qp", "st", "vu", "mn", "pq") ) == 2';
done_testing;
