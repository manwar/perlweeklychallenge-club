#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 231 Task 2: Senior Citizens
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

sub senior_citizens( @list ) {
    return scalar grep {
        /^ \d{10} [MF] (\d{2}) \d{2} $/xi
	    && $1 >= 60
    } @list;
}

run_tests;
