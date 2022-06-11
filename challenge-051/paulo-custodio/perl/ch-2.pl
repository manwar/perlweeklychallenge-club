#!/usr/bin/env perl

# Challenge 051
#
# TASK #2
# Colourful Number
# Write a script to display all Colorful Number with 3 digits.
#
# A number can be declare Colorful Number where all the products of consecutive
# subsets of digit are different.
#
# For example, 263 is a Colorful Number since 2, 6, 3, 2x6, 6x3, 2x6x3 are
# unique.

use Modern::Perl;
use List::Util qw( uniq );

my @out;
for my $a (1..9) {
    for my $b (0..9) {
        for my $c (0..9) {
            my @prods = ($a, $b, $c, $a*$b, $b*$c, $a*$b*$c);
            if (scalar(uniq(@prods))==6) {
                push @out, "$a$b$c";
            }
        }
    }
}
say join(", ", @out);
