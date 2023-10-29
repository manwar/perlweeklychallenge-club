#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 240 Task 1: Acronym
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

sub acronym( $str_aref, $chk ) {
    return $chk eq lc join "", map /^(.)/, $str_aref->@*;
}

run_tests;
