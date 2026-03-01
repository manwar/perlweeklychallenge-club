#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 362 Task 1: Echo Chamber
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub echo_chamber( $input ) {
    my $count = 0;
    return join "", map $_ x ++$count, split "", $input;
}

use Test2::V0 qw( -no_srand );

is echo_chamber( "abca" ), "abbcccaaaa",
    'Example 1: echo_chamber( "abca" ) == "abbcccaaaa"';
is echo_chamber( "xyz" ), "xyyzzz",
    'Example 2: echo_chamber( "xyz" ) == "xyyzzz"';
is echo_chamber( "code" ), "coodddeeee",
    'Example 3: echo_chamber( "code" ) == "coodddeeee"';
is echo_chamber( "hello" ), "heelllllllooooo",
    'Example 4: echo_chamber( "hello" ) == "heelllllllooooo"';
is echo_chamber( "a" ), "a",
    'Example 5: echo_chamber( "a" ) == "a"';

done_testing;
