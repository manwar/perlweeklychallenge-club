#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-236/#TASK1
#
# Task 1: Exact Change
# ====================
#
#
#
# You are asked to sell juice each costs $5. You are given an array of bills.
# You can only sell ONE juice to each customer but make sure you return exact
# change back. You only have $5, $10 and $20 notes. You do not have any change
# in hand at first.
#
# Write a script to find out if it is possible to sell to each customers with
# correct change.
#
## Example 1
##
## Input: @bills = (5, 5, 5, 10, 20)
## Output: true
##
## From the first 3 customers, we collect three $5 bills in order.
## From the fourth customer, we collect a $10 bill and give back a $5.
## From the fifth customer, we give a $10 bill and a $5 bill.
## Since all customers got correct change, we output true.
#
## Example 2
##
## Input: @bills = (5, 5, 10, 10, 20)
## Output: false
##
## From the first two customers in order, we collect two $5 bills.
## For the next two customers in order, we collect a $10 bill and give back a $5 bill.
## For the last customer, we can not give the change of $15 back because we only have two $10 bills.
## Since not every customer received the correct change, the answer is false.
#
## Example 3
##
## Input: @bills = (5, 5, 5, 20)
## Output: true
#
############################################################
##
## discussion
##
############################################################
#
# Each bill we get goes into our change hash. If we receive
# a bill > 5, we calculate the return value, then we try to
# pay it starting with a 10 bill if available. If in the end we
# still have something left to return, but no more fitting bills,
# we return false. Otherwise, we return true.
#
use strict;
use warnings;
use Data::Dumper;

exact_change(5, 5, 5, 10, 20);
exact_change(5, 5, 10, 10, 20);
exact_change(5, 5, 5, 20);

sub exact_change {
   my @bills = @_;
   my $change = {};
   print "Input: (" . join(", ", @bills) . ")\n";
   foreach my $bill (@bills) {
      $change->{$bill}++;
      my $to_return = $bill - 5;
      foreach my $return_bill (10, 5) {
         while ($to_return >= $return_bill && $change->{$return_bill} ) {
            $to_return -= $return_bill;
            $change->{$return_bill}--;
         }
      }
      if($to_return > 0) {
         print "Output: false\n";
         return;
      }
   }
   print "Output: true\n";
}
