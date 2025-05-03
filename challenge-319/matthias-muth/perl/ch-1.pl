#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 319 Task 1: Word Count
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub word_count( @list ) {
    my $vowel = qr/[aeiou]/i;
    return scalar grep / ^ $vowel | $vowel $ /xi, @list;
}

use Test2::V0 qw( -no_srand );

is word_count( "unicode", "xml", "raku", "perl" ), 2,
    'Example 1: word_count( "unicode", "xml", "raku", "perl" ) == 2';
is word_count( "the", "weekly", "challenge" ), 2,
    'Example 2: word_count( "the", "weekly", "challenge" ) == 2';
is word_count( "perl", "python", "postgres" ), 0,
    'Example 3: word_count( "perl", "python", "postgres" ) == 0';

done_testing;
