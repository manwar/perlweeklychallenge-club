#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 239 Task 2: Consistent Strings
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

sub consistent_strings( $str, $allowed ) {
    return scalar grep /^[$allowed]*$/, $str->@*;
}

run_tests;
