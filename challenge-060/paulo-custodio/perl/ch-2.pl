#!/usr/bin/env perl

# Challenge 060
#
# TASK #2 › Find Numbers
# Reviewed by: Ryan Thompson
# Write a script that accepts list of positive numbers (@L) and two positive
# numbers $X and $Y.
#
# The script should print all possible numbers made by concatenating the numbers
# from @L, whose length is exactly $X but value is less than $Y.
#
# Example
# Input:
#
# @L = (0, 1, 2, 5);
# $X = 2;
# $Y = 21;
# Output:
#
# 10, 11, 12, 15, 20

use Modern::Perl;

my($X, $Y, @L) = @ARGV;
say join(", ", grep {length($_)==$X && $_<$Y} combine(@L));

my %combin;

sub combine1 {
    my($prefix, $n, @digits) = @_;
    if (length($prefix) == $n) {
        $combin{0+$prefix} = 1;
    }
    else {
        for my $digit (@digits) {
            combine1($prefix.$digit, $n, @digits);
        }
    }
}

sub combine {
    my(@digits) = @_;
    %combin = ();
    for my $n (1 .. @digits) {
        combine1("", $n, @digits);
    }
    return sort {$a <=> $b} keys %combin;
}
