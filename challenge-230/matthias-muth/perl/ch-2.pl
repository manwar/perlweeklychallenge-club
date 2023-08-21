#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 230 Task 2: Count Words
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

sub count_words( $words, $prefix ) {
    return scalar grep /^$prefix/, @$words;
}

run_tests;
