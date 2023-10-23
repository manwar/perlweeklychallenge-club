#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 239 Task 1: Same String
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

sub same_string( $arr1, $arr2 ) {
    return join( "", $arr1->@* ) eq join( "", $arr2->@* );
}

run_tests;
