#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 307 Task 2: Find Anagrams
#
#       Perl solution by Matthias Muth.
#

use v5.36;


# 'Normalize' words by putting their letters in a defined order,
# so that words that are anagrams of each other become equal.
# (I use ascending sort because it's the default, but it doesn't
# really matter).
# We don't need to actually produce the list of kept words, we only
# need the count.

sub find_anagrams( @words ) {
    @words > 0 or return 0;
    my @normalized = map join( "", sort split "", $_ ), @words;
    return 1 + scalar grep(  $normalized[ $_ - 1 ] ne $normalized[$_],
	    1..$#normalized );
}

use Test2::V0 qw( -no_srand );
use Data::Dump qw( pp );

is find_anagrams( "acca", "dog", "god", "perl", "repl" ), 3,
    'Example 1: find_anagrams( "acca", "dog", "god", "perl", "repl" ) == 3';
is find_anagrams( "abba", "baba", "aabb", "ab", "ab" ), 2,
    'Example 2: find_anagrams( "abba", "baba", "aabb", "ab", "ab" ) == 2';

done_testing;
