#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-395/#TASK1
#
# Task 1: Complex Number
# ======================
#
# You are given two complex numbers as string.
#
# Write a script to return the multiplication of the given complex numbers.
#
## Using the formula: (a + bi) x (c + di) = (ac - bd) + (ad + bc)i
#
## Example 1
##
## Input: $num1 = "1+1i", $num2 = "1+1i"
## Output: "0+2i"
#
## Example 2
##
## Input: $num1 = "1+(-1)i", $num2 = "1+(-1)i"
## Output: "0+(-2)i"
#
## Example 3
##
## Input: $num1 = "0+3i", $num2 = "0+4i"
## Output: "-12+0i"
#
## Example 4
##
## Input: $num1 = "3+4i", $num2 = "3+(-4)i"
## Output: "25+0i"
#
## Example 5
##
## Input: $num1 = "50+(-20)i", $num2 = "-10+30i"
## Output: "100+1700i"
#
############################################################
##
## discussion
##
############################################################
#
# This is straight forward: parse the number strings, calculate the
# product, return it as a string.

use v5.36;

sub complex_number($num1, $num2) {
    say "Input: \"$num1\", \"$num2\"";
    my ($a_, $b_) = parse_num($num1);
    my ($c, $d) = parse_num($num2);
    my $real = $a_ * $c - $b_ * $d;
    my $imaginary = $a_ * $d + $b_ * $c;
    if($imaginary < 0) {
        $imaginary = "($imaginary)";
    }
    say "Output: \"$real+${imaginary}i";
}

sub parse_num($num) {
    my ($real, $imaginary);
    $num =~ s/^(-?[\d.]+)\+//;
    $real = $1;
    $num =~ s/i$//;
    $num =~ s/\(//;
    $num =~ s/\)//;
    $imaginary = $num;
    return ($real, $imaginary);
}

complex_number("1+1i", "1+1i");
complex_number("1+(-1)i", "1+(-1)i");
complex_number("0+3i", "0+4i");
complex_number("3+4i", "3+(-4)i");
complex_number("50+(-20)i", "-10+30i");
