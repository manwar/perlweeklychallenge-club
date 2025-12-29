#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 353 Task 1: Max Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;
use List::Util qw( max );

sub max_words( @sentences ) {
    return max( map scalar( split " " ), @sentences );
}

use Test2::V0 qw( -no_srand );

is max_words( "Hello world", "This is a test", "Perl is great" ), 4,
    'Example 1: max_words( ... ) == 4';
is max_words( "Single" ), 1,
    'Example 2: max_words( "Single" ) == 1';
is max_words(
    "Short",
    "This sentence has seven words in total", "A B C",
    "Just four words here" ), 7,
    'Example 3: max_words( ... ) == 7';
is max_words( "One", "Two parts", "Three part phrase", "" ), 3,
    'Example 4: max_words( "One", "Two parts", "Three part phrase", "" ) == 3';
is max_words(
    "The quick brown fox jumps over the lazy dog",
    "A",
    "She sells seashells by the seashore",
    "To be or not to be that is the question" ), 10,
    'Example 5: max_words( ... ) == 10';

done_testing;
