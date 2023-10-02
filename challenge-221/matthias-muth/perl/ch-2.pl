#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 221 Task 2: Arithmetic Subsequence
#
#       Perl solution by Matthias Muth.
#

use strict;
use warnings;
use feature 'say';

use lib '.';
use TestExtractor;

sub arithmetic_subsequence {
    my @ints = @_;

    my $max = 0;
    # Choose a starting number.
    for my $i ( 0..$#ints ) {
	# Choose a second number from the rest of the list.
        for my $j ( $i + 1 .. $#ints ) {
	    # The two numbers already form an arithmetic subsequence
	    # of length 2.
	    my $count = 2;
	    # Go through the rest of the list looking for more numbers with
	    # the same difference between them.
	    my $diff = $ints[$j] - $ints[$i];
	    my $next_expected = $ints[$j] + $diff;
	    for my $k ( $j + 1 .. $#ints ) {
		if ( $ints[$k] == $next_expected ) {
		    $count++;
		    $next_expected += $diff;
		}
	    }
	    vsay "chain starting with $ints[$i] and $ints[$j] (diff: $diff):",
		" $count numbers";
	    $max = $count
		if $count > $max;
	}
    }
    return $max;
}

run_tests;
