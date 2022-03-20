#!/bin/perl

=pod

The Weekly Challenge - 156
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-156/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Pernicious Numbers
Submitted by: Mohammad S Anwar

Write a script to permute first 10 Pernicious Numbers.

 || A pernicious number is a positive integer which has prime number of ones 
 || in its binary representation.

The first pernicious number is 3 since binary representation of 3 = (11) and 
1 + 1 = 2, which is a prime.

Expected Output

3, 5, 6, 7, 9, 10, 11, 12, 13, 14

=cut

use v5.16;

use Math::Primality qw(is_prime);

my @pN;

my $i = 1;
while (scalar @pN < 10) {
  push(@pN,$i) if (is_prime(scalar(grep/1/,split(//,sprintf('%b',$i)))));
  $i++;
}

say join(',',@pN);
