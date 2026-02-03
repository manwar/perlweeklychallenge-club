#!/usr/bin/env perl

# Challenge 323
#
# Task 2: Tax Amount
# Submitted by: Mohammad Sajid Anwar
# You are given an income amount and tax brackets.
#
# Write a script to calculate the total tax amount.
#
#
# Example 1
# Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
# Output: 2.65
#
# 1st tax bracket upto  3, tax is 50%.
# 2nd tax bracket upto  7, tax is 10%.
# 3rd tax bracket upto 12, tax is 25%.
#
# Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
#           => 1.50 + 0.40 + 0.75
#           => 2.65
#
# Example 2
# Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
# Output: 0.25
#
# Total Tax => (1 * 0/100) + (1 * 25/100)
#           => 0 + 0.25
#           => 0.25
#
# Example 3
# Input: $income = 0, @tax = ([2, 50])
# Output: 0

use Modern::Perl;
use List::Util qw(min);

chomp(my $income = <>);
my @tax;
while (<>) {
    push @tax, [split ' ', $_];
}
say compute_tax($income, @tax);

sub compute_tax {
    my($income, @tax) = @_;
    my $tax = 0;
    my $base = 0;
    while (@tax && $income > $base) {
        my $taxable = min($income - $base, $tax[0][0] - $base);
        $tax += $taxable * $tax[0][1] / 100;
        $base = $tax[0][0];
        shift @tax;
    }
    return $tax;
}
