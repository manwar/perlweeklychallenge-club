#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are asked to sell juice each costs $5. You are given an array of bills. You can only sell ONE juice to each customer but make sure you return exact change back. You only have $5, $10 and $20 notes. You do not have any change in hand at first. 
Write a script to find out if it is possible to sell to each customers with correct change.
Example 1 Input: @bills = (5, 5, 5, 10, 20) Output: true
From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.

Example 2 Input: @bills = (5, 5, 10, 10, 20) Output: false
From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bill.
For the last customer, we can not give the change of $15 back because we only have two $10 bills.
Since not every customer received the correct change, the answer is false.
=cut

use Test2::V0;

sub exact_change
{
     my @bills = @_;
     my %change;
     for my $bill ( @bills )
     {
          if ( $bill == 5 )
          {
               $change{$bill}++;
          }
          elsif ( $bill == 10 )
          {
               if ( $change{5} > 0 )
               {
                    $change{$bill}++;
                    $change{5}--;
               }
               else
               {
                    return 'false';
               }
          }
          elsif ( $bill == 20 )
          {
               if ( $change{5} > 2 ) 
               { 
                    $change{$bill}++; 
                    $change{5} -= 3; 
               }
               elsif ( $change{5} > 0 and $change{10} > 0 )
               {
                    $change{$bill}++;
                    $change{5}--;
                    $change{10}--;
               }
               else
               {
                    return 'false';
               }
          }
     }
     return 'true';
}


is(exact_change(5, 5, 5, 10, 20), 'true', 'Example 1');
is(exact_change(5, 5, 10, 10, 20), 'false', 'Example 2');
done_testing();
