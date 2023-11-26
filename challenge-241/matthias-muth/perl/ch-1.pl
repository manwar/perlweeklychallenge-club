#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 241 Task 1: Arithmetic Triplets
#
#       Perl solution by Matthias Muth.
#

use v5.20;
use strict;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use lib '.';
use TestExtractor;

sub arithmetic_triplets( $nums_aref, $diff ) {
    # Copy the array ref into a local array (only for easier reading).
    my @nums = $nums_aref->@*;
    # Create a lookup for all numbers.
    my %nums = map { ( $_ => 1 ) } @nums;
    # Return the number of numbers fulfilling the criteria.
    return scalar grep
        exists $nums{ $_ + $diff } && exists $nums{ $_ + 2 * $diff },
        @nums;
}

run_tests;
