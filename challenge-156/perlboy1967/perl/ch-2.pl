#!/bin/perl

=pod

The Weekly Challenge - 156
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-156/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Weird Number
Submitted by: Mohammad S Anwar

You are given number, $n > 0.

Write a script to find out if the given number is a Weird Number.

According to Wikipedia, it is defined as:

  || The sum of the proper divisors (divisors including 1 but not itself) 
  || of the number is greater than the number, but no subset of those divisors 
  || sums to the number itself.

=cut

use v5.16;

use List::Util qw(sum);
use Algorithm::Combinatorics qw(combinations);

sub isWeirdNumber($);
sub divisors($);

@ARGV = (12, 70, 252, 111, 836, 4030, 5830, 7192, 7912, 9272, 10430, 10570, 10792, 10990, 11410, 11690, 12110, 12530, 12670, 13370, 13510, 13790, 13930, 14770) unless (@ARGV);

foreach my $n (@ARGV) {
  say "n=$n => ",isWeirdNumber($n);
}


sub isWeirdNumber($) {
  my ($n) = @_;

  # Get proper divisors
  my @d = (1, grep {$n % $_ == 0} 2 .. $n >> 1);

  my $sum = sum(@d);
  my $delta = $sum - $n;

  return 0 if ($delta < 0 or 
               grep { $_ == $delta } @d);

  my @r = grep { $_ <= $delta } @d;
  foreach my $i (2 .. scalar(@r)) {
    my $iter = combinations(\@r, $i);
    while (my $ar = $iter->next) {
      return 0 if (sum(@$ar) == $delta);
    }
  }

  return 1;
}

