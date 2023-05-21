#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 217 Task 1: Sorted Matrix
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

sub sorted_matrix {
    return ( sort { $a <=> $b } map @$_, @{$_[0]} )[2];
}

use lib '.';
use TestExtractor;
run_tests();
