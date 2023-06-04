#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 219 Task 1: Sorted Squares
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

sub sorted_squares {
    return sort { $a <=> $b } map { $_ ** 2 } @_;
}

run_tests;
