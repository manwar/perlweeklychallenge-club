#!/bin/perl

=pod

The Weekly Challenge - 148
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-148/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Cardano Triplets
Submitted by: Mohammad S Anwar

Write a script to generate first 5 Cardano Triplets.

  A triplet of positive integers (a,b,c) is called a Cardano Triplet if it 
  satisfies the below condition.

  cbrt(a + b * sqrt(c) + cbrt(a - b * sqrt(c)) = 1

  (or 8*a^3 + 15*a^2 + 6*a - 27*b^2*c = 1)

=cut

use v5.16;

use Data::Printer output => 'stdout';

use Inline 'C';

my $i = 0;
my $num = shift // 5;

foreach my $a (1..100) {
  foreach my $b (1..100) {
    foreach my $c (1..100) {
      if (isCardano($a,$b,$c)) {
        say "($a,$b,$c)";
        $i++;
        exit if ($i >= $num);
      }
    }
  }
}


__END__
__C__
int isCardano(int a, int b, int c) {
  return 8*a*a*a + 15*a*a + 6*a - 27*b*b*c == 1;
}
 
