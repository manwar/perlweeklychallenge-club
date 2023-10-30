#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 235 Task 1: Remove One
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

use List::Util qw( any all );

sub is_monotonic( @a ) {
    return all { $a[$_] > $a[ $_ - 1 ] } 1..$#a;
}

sub remove_one( @ints ) {
    return
	any {
	    my @try = @ints;
	    splice @try, $_, 1, ();
	    is_monotonic @try;
	} 0..$#ints;
}

run_tests;

__DATA__
Test 1: Perfect array
Input: @ints = ( 1, 2, 3, 4, 5, 6 )
Output: true

Test 2: README Example 1
Input: @ints = ( 1, 2, 3, 0, 4, 5, 6 )
Output: true

Test 1: README Example 2
Input: @ints = ( 1, 2, 3, 99, 4, 5, 6 )
Output: true
