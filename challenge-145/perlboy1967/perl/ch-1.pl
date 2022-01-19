#!/bin/perl

=pod

The Weekly Challenge - 145
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-145/#TASK1

Author: Niels 'PerlBoy' van Dijke

TASK #1 › Dot Product
Submitted by: Mohammad S Anwar

You are given 2 arrays of same size, @a and @b.

Write a script to implement Dot Product.

=cut

use v5.16;
use strict;
use warnings;

use List::Util qw(sum);
use List::MoreUtils qw(pairwise);

sub dotProduct(\@\@) {
  my ($c,$d) = @_;
  no warnings 'once';
  return sum pairwise{$a*$b}@$c,@$d;
}

my @a = (1,2,3);
my @b = (2,3,4);

printf "dotProduct of (%s) and (%s) = %d\n",
  join(',',@a), join(',',@b), dotProduct(@a,@b);

