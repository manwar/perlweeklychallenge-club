#!/usr/bin/env perl
use v5.36;

# Task 2: Reversible Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to find out all Reversible Numbers below 100.
#
#     A number is said to be a reversible if sum of the number and its
#     reverse had only odd digits.
#
# For example,
#
# 36 is reversible number as 36 + 63 = 99 i.e. all digits are odd.
# 17 is not reversible as 17 + 71 = 88, none of the digits are odd.

sub is_reversible($i) {
    return ($i + scalar reverse $i) !~ /[02468]/;
}

my @reversible;
for my $i (1..99) {
    push @reversible, $i if is_reversible($i);
}

say "@reversible";
