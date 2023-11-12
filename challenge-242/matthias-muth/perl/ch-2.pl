#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 242 Task 2: Flip Matrix
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

sub flip_matrix( $matrix ) {
    return map [ map $_ ^ 1, reverse $_->@* ], $matrix->@*;
}

run_tests;
