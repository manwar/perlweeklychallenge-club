#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 226 Task 1: Shuffle String
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

sub shuffle_string( $string, $indices ) {
    my @results;
    @results[ @$indices ] = split //, $string;
    return join "", @results;
}

run_tests;
