#!/bin/perl

=pod

The Weekly Challenge - 323
L<https://theweeklychallenge.org/blog/perl-weekly-challenge-323#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Tax Amount
Submitted by: Mohammad Sajid Anwar

You are given an income amount and tax brackets.

Write a script to calculate the total tax amount.

|| Example 1
|| 
|| Input: $income = 10, @tax = ([3, 50], [7, 10], [12,25])
|| Output: 1.65
|| 
|| 1st tax bracket upto  3, tax is 50%.
|| 2nd tax bracket upto  7, tax is 10%.
|| 3rd tax bracket upto 12, tax is 25%.
|| 
|| Total Tax => (3 * 50/100) + (4 * 10/100) + (3 * 25/100)
||           => 1.50 + 0.40 + 0.75
||           => 2.65

=cut

use v5.32;
use common::sense;
use feature qw(signatures);
use Test2::V0 qw(-no_srand);
no warnings qw(experimental::signatures);

sub taxAmount ($income,@taxBrackets) {
  @taxBrackets = map { [$$_[0],$$_[1]/100] } 
                   sort { $$a[0] <=> $$b[0] } @taxBrackets;

  # Get last bracket via [0,x]
  my @lastBracket = $taxBrackets[0][0] == 0 ? @{shift @taxBrackets} : (0,0);
  $lastBracket[0] = $taxBrackets[-1][0] if $lastBracket[1];

  my ($tax,$lo) = (0,0);
  while (@taxBrackets) {
    my ($hi,$bracket) = @{shift @taxBrackets};
    $hi = $income if $income < $hi;
    $tax += ($hi - $lo) * $bracket;
    last if $hi > $income;
    $lo = $hi;
  }

  # Process last bracket (if needed)
  $tax += ($income - $lastBracket[0]) * $lastBracket[1] 
   if ($lastBracket[1] and $income > $lastBracket[0]);

  return int($tax * 100 + 0.5)/100;
}

is(taxAmount(10,@{[[3,50],[7,10],[12,25]]}),2.65,'Example 1');
is(taxAmount(2,@{[[1,0],[4,25],[5,50]]}),0.25,'Example 2');
is(taxAmount(0,@{[[2,50]]}),0,'Example 3');

is(taxAmount(50,@{[[100,10],[0,50]]}),5,'Own example with high tax bracket');

is(taxAmount(200_000.00,@{[[15820,25],[27920,40],[48320,45],[0,50]]}),
              93_815.00,'United States (USD)');
is(taxAmount(200_000.00,@{[[38441,35.82],[76817,37.48],[0,49.50]]}),
              89_128.48,'The Netherlands (Euro)');
is(taxAmount(200_000.00,@{[[12570,0],[50270,20],[125140,40],[0,45]]}),
              71_175.00,'United Kingdom (GBP)');
is(taxAmount(200_000.00,@{[[11497,0],[29315,11],[83823,30],[180294,41],[0,45]]}),
              66_733.19,'France (Euro)');
is(taxAmount(200_000.00,@{[[11600,10],[47150,12],[100525,22],[191950,24]]}),
              39_110.50,'United States (USD)');

done_testing;
