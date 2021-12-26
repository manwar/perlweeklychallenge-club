#!/bin/perl

=pod

The Weekly Challenge - 144
 - https://perlweeklychallenge.org/blog/perl-weekly-challenge-144/#TASK2

Author: Niels 'PerlBoy' van Dijke

TASK #2 › Ulam Sequence
Submitted by: Mohammad S Anwar

You are given two positive numbers, $u and $v.

Write a script to generate Ulam Sequence having at least 10 Ulam numbers
where $u and $v are the first 2 Ulam numbers.

For more information about Ulam Sequence, please checkout the website.

|| The standard Ulam sequence (the (1, 2)-Ulam sequence) starts with U1 = 1 
|| and U2 = 2. Then for n > 2, Un is defined to be the smallest integer that
|| is the sum of two distinct earlier terms in exactly one way and larger 
|| than all earlier terms.

=cut

use v5.16;
use strict;
use warnings;

use Algorithm::Combinatorics qw(combinations);
use List::Util qw(sum);
use List::MoreUtils qw(firstidx);

sub getUlamSequence($$$);

my ($U,$V,$N) = (2,5,10);
($U,$V,$N) = @ARGV if (scalar(@ARGV) == 3);

printf 'Input: $u = %d, $v = %d, $n = %d'."\n", $U,$V,$N;
printf "Output: %s\n", join(',',getUlamSequence($U,$V,$N));

sub getUlamSequence($$$) {
  my ($u,$v,$n) = @_;

  my @s = ($u,$v);
  while (scalar(@s) < $n) {
    my %v;
    my $c = combinations(\@s, 2);
    while (my $ar = $c->next) {
      my $sum = sum @$ar;
      $v{$sum}++ if ($sum > $s[-1]);
    }
    my @v = sort{$a<=>$b} keys %v;
    push(@s,$v[firstidx{$v{$_} == 1} @v]) ;
  }

  return @s;
}

