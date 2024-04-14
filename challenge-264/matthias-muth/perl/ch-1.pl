#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 264 Task 1: Greatest English Letter
#
#       Perl solution by Matthias Muth.
#

use v5.36;

sub greatest_english_letter( $str ) {
    my %have = map { ( $_ => 1 ) } split "", $str;
    return ( sort grep /^[A-Z]/ && $have{ lc $_ }, keys %have )[-1] // "";
}

use Test2::V0 qw( -no_srand );
is greatest_english_letter( "PeRlwEeKLy" ), "L",
    'Example 1: greatest_english_letter( "PeRlwEeKLy" ) == "L"';
is greatest_english_letter( "ChaLlenge" ), "L",
    'Example 2: greatest_english_letter( "ChaLlenge" ) == "L"';
is greatest_english_letter( "The" ), "",
    'Example 3: greatest_english_letter( "The" ) == ""';
done_testing;
