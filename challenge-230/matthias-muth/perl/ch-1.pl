#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 230 Task 1: Separate Digits
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

sub separate_digits( @ints ) {
    return split "", join "", @ints;
}

run_tests;
