#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 226 Task 2: Zero Array
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

use List::Util qw( uniq );

sub zero_array( @ints ) {
    return scalar uniq grep $_ != 0, @ints;
}

run_tests;
