#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 238 Task 1: Running Sum
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

use List::Util qw( reduce reductions );

sub sum( @int ) {
    return reduce { $a + $b } @int;
}

sub running_sum( @int ) {
    # return reductions { $a + $b } @int;
    return map sum( @int[0..$_] ), 0..$#int;
}

run_tests;
