#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 313 Task 2: Reverse Letters
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub reverse_letters( $str ) {
    my @reversed_letters = reverse $str =~ /[[:alpha:]]/g;
    my $index = 0;
    return $str =~ s/[[:alpha:]]/$reversed_letters[$index++]/gr;
}

use Test2::V0 qw( -no_srand );

is reverse_letters( "p-er?l" ), "l-re?p",
    'Example 1: reverse_letters( "p-er?l" ) == "l-re?p"';
is reverse_letters( "wee-k!L-y" ), "yLk-e!e-w",
    'Example 2: reverse_letters( "wee-k!L-y" ) == "yLk-e!e-w"';
is reverse_letters( "_c-!h_all-en!g_e" ), "_e-!g_nel-la!h_c",
    'Example 3: reverse_letters( "_c-!h_all-en!g_e" ) == "_e-!g_nel-la!h_c"';

done_testing;
