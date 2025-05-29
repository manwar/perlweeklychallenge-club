#!/usr/bin/env perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-323/#TASK2
#
# Task 2: Tax Amount
# ==================
#
# You are given an income amount and tax brackets.
#
# Write a script to calculate the total tax amount.
#
## Example 1
##
## Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
## Output: 2.65
##
## 1st tax bracket upto  3, tax is 50%.
## 2nd tax bracket upto  7, tax is 10%.
## 3rd tax bracket upto 12, tax is 25%.
##
## Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
##           => 1.50 + 0.40 + 0.75
##           => 2.65
#
#
## Example 2
##
## Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
## Output: 0.25
##
## Total Tax => (1 * 0/100) + (1 * 25/100)
##           => 0 + 0.25
##           => 0.25
#
#
## Example 3
##
## Input: $income = 0, @tax = ([2, 50])
## Output: 0
#
############################################################
##
## discussion
##
############################################################
#
# First of all, there is no indication what should happen once
# all tax brackets have been used up. I'm going to assume the tax
# is zero in that case.
# Then we just check each bracket, always keeping track of the previous
# bracket to know how big the part will be for the current bracket,
# and calculate the tax.

use v5.36;

tax_amount(10, [3, 50], [7, 10], [12,25]);
tax_amount(2, [1, 0], [4, 25], [5,50]);
tax_amount(0, [2, 50]);
tax_amount(5, [2, 50]);

sub tax_amount($income, @tax) {
    say "Income: $income";
    print "Tax brackets: (";
    foreach my $t (@tax) {
        print "[$t->[0], $t->[1]], ";
    }
    say ")";
    my $tax = 0;
    my $previous = 0;
    foreach my $t (@tax) {
        my $end = $t->[0];
        my $percent = $t->[1];
        if($income <= $end) {
            $tax += ($income - $previous) * $percent / 100;
            last;
        } else {
            $tax += ($end - $previous) * $percent / 100;
            $previous = $end;
        }
    }
    say "Output: $tax";
}
