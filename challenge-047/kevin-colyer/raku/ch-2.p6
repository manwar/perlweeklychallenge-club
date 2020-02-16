#!/usr/bin/perl6
use v6;

use Test;


=begin pod

TASK #2
Gapful Number
Write a script to print first 20 Gapful Numbers greater than or equal to 100. Please check out the page for more information about Gapful Numbers. https://oeis.org/A108343

=end pod

# make a lazy sequence 100 to infinity
my @gapful = (100...Inf)
        # filter each number with grep
    .grep: {
        # keeping it if it divides with no remainder it's first character * 10 plus its last character
        $_ %% ( $_.substr( 0, 1 ) * 10 + $_.substr( *-1, 1 ) )
    };

# select counting up to 20 from 0, pass the list to say with a hyper operation
@gapful[^20]>>.say;
