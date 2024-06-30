#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 275 Task 1: Broken Keys
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub broken_keys( $sentence, $keys ) {
    my $keys_as_string = join( "", $keys->@* );
    return scalar grep ! /[$keys_as_string]/i, split " ", $sentence;
}

use Test2::V0 qw( -no_srand );
is broken_keys( "Perl Weekly Challenge", ["l", "a"] ), 0,
    'Example 1: broken_keys( "Perl Weekly Challenge", ["l", "a"] ) == 0';
is broken_keys( "Perl and Raku", ["a"] ), 1,
    'Example 2: broken_keys( "Perl and Raku", ["a"] ) == 1';
is broken_keys( "Well done Team PWC", ["l", "o"] ), 2,
    'Example 3: broken_keys( "Well done Team PWC", ["l", "o"] ) == 2';
is broken_keys( "The joys of polyglottism", ["T"] ), 2,
    'Example 4: broken_keys( "The joys of polyglottism", ["T"] ) == 2';
done_testing;
