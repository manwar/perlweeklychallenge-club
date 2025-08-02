#!/usr/bin/env perl
#
# You are asked to sell juice each costs $5. You are given an array of bills.
# You can only sell ONE juice to each customer but make sure you return exact
# change back. You only have $5, $10 and $20 notes. You do not have any change in
# hand at first.
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
# For the last customer, we can not give the change of $15 back because we only
# have two $10 bills.
# Since not every customer received the correct change, the answer is false.
# 
# Example 3
# 
# Input: @bills = (5, 5, 5, 20)
# Output: true
# 

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
	[5, 5, 5, 10, 20],
	[5, 5, 10, 10, 20],
	[5, 5, 5, 20],
];

sub exact_change
{
	my $bill = shift;

    my %change = (
         5 => 0,
        10 => 0,
        20 => 0,
    );
    my $ret = 1;
	for my $bill (@$bill) {
        ++$change{$bill};
		if ($bill == 10) {
            if ($change{5}) {
                --$change{5};
            } else {
                $ret = 0;
                last;
            }
		} elsif ($bill == 20) {
            if ($change{5} && $change{10}) {
                --$change{5};
                --$change{10};
            } elsif ($change{5} >= 3) {
                $change{5} -= 3;
            } else {
                $ret = 0;
                last;
            }
		}
	}

	return $ret;
}

is(exact_change($cases->[0]), 1, 'Example 1');
is(exact_change($cases->[1]), 0, 'Example 2');
is(exact_change($cases->[2]), 1, 'Example 3');
done_testing();

exit 0;
