#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given an income amount and tax brackets.

Write a script to calculate the total tax amount.

Example 1

Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
Output: 2.65

1st tax bracket upto  3, tax is 50%.
2nd tax bracket upto  7, tax is 10%.
3rd tax bracket upto 12, tax is 25%.

Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
          => 1.50 + 0.40 + 0.75
          => 2.65


Example 2

Input: $income = 2, @tax = ([1, 0], [4, 25], [5,50])
Output: 0.25

Total Tax => (1 * 0/100) + (1 * 25/100)
          => 0 + 0.25
          => 0.25


Example 3

Input: $income = 0, @tax = ([2, 50])
Output: 0
=cut


use Test2::V0 -no_srand => 1;
is(tax_amount(10, [[3, 50], [7, 10], [12,25]]), 2.65, 'Example 1');
is(tax_amount(2, [[1, 0], [4, 25], [5,50]]), 0.25, 'Example 2');
is(tax_amount(0, [[2, 50]]), 0, 'Example 3');
done_testing();

sub tax_amount
{
     my ($income, $tax_aref) = @_;
     my $tax_amount = 0;
     my $marker = 0;
     for my $slot ( @$tax_aref )
     {
          my $up_to = $slot->[0];
          my $tax = $slot->[1]/100;
          if ( $marker < $up_to )
          {
               if ( $income >= $up_to )
               {
                    $tax_amount += ($up_to - $marker) * $tax;
                    $marker = $up_to;
               }
               elsif ( $income < $up_to )
               {
                    $tax_amount += ($income - $marker) * $tax;
                    last;
               }
          }
     }
     return $tax_amount;
}
