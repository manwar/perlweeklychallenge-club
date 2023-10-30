#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 235 Task 2: Duplicate Zeros
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

sub duplicate_zeros( @ints ) {
    vsay "duplicate_zeros( @ints )";
    for ( reverse grep $ints[$_] == 0, 0 .. $#ints - 1 ) {
	vsay "splicing at $_ + 1;";
	splice @ints, $_ + 1, $#ints - $_, ( @ints[ $_ .. $#ints - 1 ] );
	vsay "@ints";
    }
    return @ints;
}

run_tests;

__END__
Test 1:
Input: @ints = ( 1, 2, 0 )
Output: ( 1, 2, 0 )
