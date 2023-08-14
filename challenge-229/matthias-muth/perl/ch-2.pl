#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 229 Task 2: Two out of Three
#
#       Perl solution by Matthias Muth.
#

use v5.36;

use lib '.';
use TestExtractor;

use List::Util qw( uniq );

sub two_out_of_three ( $array1, $array2, $array3 ) {
    my %frequencies;
    $frequencies{$_}++
	for map uniq( @$_ ), $array1, $array2, $array3;
    vsay "frequencies: ", pp \%frequencies;
    return sort { $a <=> $b } grep { $frequencies{$_} >= 2 } keys %frequencies;
}

run_tests;
