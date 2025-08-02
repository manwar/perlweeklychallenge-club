#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 315 Task 2: Find Third
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub find_third( $sentence, $first, $second ) {
    my @words = $sentence =~ /([[:alpha:]]+)/g;
    return
	map $words[$_],
	    grep $words[ $_ - 2 ] eq $first && $words[ $_ - 1 ] eq $second,
		2..$#words;
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is [ find_third( "Perl is a my favourite language but Python is my favourite too.", "my", "favourite" ) ], [ "language", "too" ],
    'Example 1: find_third( "Perl is a my favourite language but Python is my favourite too.", "my", "favourite" ) == ("language", "too")';
is [ find_third( "Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful" ) ], [ "doll", "princess" ],
    'Example 2: find_third( "Barbie is a beautiful doll also also a beautiful princess.", "a", "beautiful" ) == ("doll", "princess")';
is [ find_third( "we will we will rock you rock you.", "we", "will" ) ], [ "we", "rock" ],
    'Example 3: find_third( "we will we will rock you rock you.", "we", "will" ) == ("we", "rock")';

is [ find_third( "Das ist so schön, weil das so schön ist", "so", "schön" ) ], [ "weil", "ist" ],
    'German example: find_third( "Das ist so schön, weil das so schön ist", "so", "schön" ) == ("weil", "ist")';

done_testing;
