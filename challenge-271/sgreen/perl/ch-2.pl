#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub one_bits($int) {
    # Convert the integer to binary, and count the number of 1s
    my $bin = sprintf( "%b", $int );
    return ($bin =~ tr/1/1/);
}

sub sort_by_1_bits (@ints) {
    # Sort the integers by the number of 1 bits, and by the integer value if
    #  the number of 1 bits is the same
    my @sorted = sort { one_bits($a) <=> one_bits($b) || $a <=> $b } @ints;
    say '(' . join( ', ', @sorted ) . ')';
}

sort_by_1_bits(@ARGV);