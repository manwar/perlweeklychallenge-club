#!/bin/perl

=pod

The Weekly Challenge - 141
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-141/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Like Numbers
Submitted by: Mohammad S Anwar

i You are given positive integers, $m and $n.

Write a script to find total count of integers created using the digits of $m
which is also divisible by $n.

Repeating of digits are not allowed. Order/Sequence of digits can’t be 
altered. You are only allowed to use (n-1) digits at the most. For example, 
432 is not acceptable integer created using the digits of 1234. Also for 1234,
you can only have integers having no more than three digits.

=cut

use v5.16;
use strict;
use warnings;

use List::MoreUtils qw(uniq);
use Algorithm::Combinatorics qw(combinations);

sub likeNumbers($$);

my @n = likeNumbers($ARGV[0],$ARGV[1]);
printf "%d => (%s)\n", scalar(@n), join(',',@n);


sub likeNumbers($$) {
  my ($m,$n) = @_;

  my @res;

  my @digits = uniq split //,$m;
  foreach my $len (1 .. scalar(@digits)) {  
    my $iter = combinations(\@digits,$len);
    while (my $ar = $iter->next) {
      my $val = join('',@$ar);
      push(@res,$val) if ($val % $n == 0 and $val != $m);
    }
  }

  return @res;
}
