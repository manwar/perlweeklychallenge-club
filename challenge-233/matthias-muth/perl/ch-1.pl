#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 233 Task 1: Similar Words
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

use List::Util qw( sum uniq );

sub similar_words( @words ) {

    # Map each word into its alphabet word.
    # A word's alphabet word consists of one of each letter contained in the
    # word, ordered alphabetically.
    # Thwo words are 'similar' in the sense of this challenge task if their
    # alphabet words are equal.
    # Get the number of 'similar' words by keeping a counter of how often
    # the same alphabet word was produced.
    my %alphabet_counts;
    for my $word ( @words ) {
        my $alphabet = join "", sort( uniq( split "", $word ) );
        ++$alphabet_counts{$alphabet};
    }

    # For getting the number of possible pairs, if n is the number of words
    # that have the same alphabet, we have n ways to choose the first element
    # of the pair, and (n-1) to choose the second one. As we don't want to
    # count the same pair twice (also in its reversed form), we divide by two.
    # Actually this corresponds to the more elaborate form of computing
    # the 'n choose k' combinations, which is
    #     C( n, k ) = n! / k!(n-k)!
    #               = n! / 2(n-2)!
    #               = ( n (n-1) (n-2) ... 1 ) / 2 ( n-2 ... 1 )
    #               = n (n-1) / 2
    return sum(
        map $_ * ( $_ - 1 ) / 2,
	    values %alphabet_counts
    );
}

run_tests;
