#!/usr/bin/env perl
#
#       The Weekly Challenge - Perl & Raku
#       (https://theweeklychallenge.org)
#
#       Challenge 237 Task 2: Maximise Greatness
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

sub maximise_greatness( @nums ) {
    # Sort the numbers, highest first.
    @nums = sort { $b <=> $a } @nums;

    # Our 'permuted' array starts out the same, highest values first.
    my @permuted = @nums;

    # Now we compare the corresponding numbers one by one.
    # If the current 'attacker' value is greater than the number, that's great!
    # (pun intended!) and we can leave the attacker in that position.
    # If instead the 'attacker' is less or equal than the number, we have no
    # chance of finding a better one (remember the available values are
    # sorted highest first).
    # We therefore move the *lowest* attacker value into that position,
    # 'waisting it' on the number that we could not win.
    # This keeps our best chances of winning other numbers.
    # We also move all the rest of the permuted to the right by one position.
    # The current attacker will then have another chance with the next number.

    my $greatness = 0;
    for ( 0..$#nums ) {
        if ( $permuted[$_] > $nums[$_] ) {
	    ++$greatness;
	}
	else {
	    # Move the last element to the current position,
	    # shifting the rest to the right.
	    splice @permuted, $_, 0, pop @permuted;
	}
    }
    vsay "permuted: ", join " ", @permuted;
    vsay "nums:      ", join " ", @nums;
    return $greatness;
}

run_tests;
