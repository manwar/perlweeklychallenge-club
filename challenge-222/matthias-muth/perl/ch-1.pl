#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 222 Task 1: Matching Members
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

use List::Util qw( sum );

sub matching_members {
    my @ints = @_;
    my @sorted_ints = sort { $a <=> $b } @ints;
    return sum map { $ints[$_] == $sorted_ints[$_] } 0..$#ints;
}

run_tests;
