#!/usr/bin/perl

use v5.16;
use warnings;
use List::MoreUtils 'slide';


### Implementation
# First row is a single one.
# In the following rows, each element is the sum of the two elements
# from the row above, where this is embedded between two zeroes.

main: {
    my @row = (1);
    for (1 .. shift) {
        say "@row";
        @row = slide {$a + $b} 0, @row, 0;
    }
}
