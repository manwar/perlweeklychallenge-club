#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 228 Task 1: Unique Sum
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

use List::Util qw( sum );
use List::MoreUtils qw( singleton );

sub unique_sum( @int ) {
    return sum( singleton @int ) // 0;
}

sub unique_sum_core_only( @int ) {
    my %frequencies;
    $frequencies{$_}++
        for @int;
    return sum(
        grep { $frequencies{$_} == 1 } keys %frequencies
    ) // 0;
}

run_tests;
