#!/usr/bin/env perl

# Challenge 236
#
# Task 1: Exact Change
# Submitted by: Mohammad S Anwar
#
# You are asked to sell juice each costs $5. You are given an array of bills.
# You can only sell ONE juice to each customer but make sure you return exact
# change back. You only have $5, $10 and $20 notes. You do not have any change
# in hand at first.
#
# Write a script to find out if it is possible to sell to each customers with
# correct change.
# Example 1
#
# Input: @bills = (5, 5, 5, 10, 20)
# Output: true
#
# From the first 3 customers, we collect three $5 bills in order.
# From the fourth customer, we collect a $10 bill and give back a $5.
# From the fifth customer, we give a $10 bill and a $5 bill.
# Since all customers got correct change, we output true.
#
# Example 2
#
# Input: @bills = (5, 5, 10, 10, 20)
# Output: false
#
# From the first two customers in order, we collect two $5 bills.
# For the next two customers in order, we collect a $10 bill and give back a $5 bill.
# For the last customer, we can not give the change of $15 back because we only have two $10 bills.
# Since not every customer received the correct change, the answer is false.
#
# Example 3
#
# Input: @bills = (5, 5, 5, 20)
# Output: true

use Modern::Perl;

my $PRICE = 5;

my @customers = @ARGV;
say is_exact_change(@customers) ? "true" : "false";

sub is_exact_change {
    my(@customers) = @_;
    my @bills;
    while (@customers) {
        my $received = shift @customers;
        $bills[$received]++;
        my $change = $received - $PRICE;
        while ($change != 0) {
            my $found;
            for my $bill (reverse 0..$#bills) {
                if (defined($bills[$bill]) && $change >= $bill && $bills[$bill] > 0) {
                    $bills[$bill]--;
                    $change -= $bill;
                    $found = 1;
                    last;
                }
            }
            next if $found;
            return 0;       # not possible to give correct change
        }
    }
    return 1;
}
