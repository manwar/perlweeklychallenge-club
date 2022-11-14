#!/bin/perl

=pod

The Weekly Challenge - 191
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-191/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: Cute List
Submitted by: Mohammad S Anwar

You are given an integer, 0 < $n <= 15.

Write a script to find the number of orderings of numbers that form a cute list.

With an input @list = (1, 2, 3, .. $n) for positive integer $n, an ordering of @list
is cute if for every entry, indexed with a base of 1, either

1) $list[$i] is evenly divisible by $i
or
2) $i is evenly divisible by $list[$i]

=cut

use v5.16;
use warnings;

use Time::HiRes qw(gettimeofday tv_interval);
use Algorithm::Permute;
use List::MoreUtils qw(firstidx);
use Memoize;

memoize('isCuteEntry');

use Data::Printer output => 'stdout';

sub isCuteEntry ($$) {
  state $c;
  my $idx = $_[0].'|'.$_[1];

  return $c->{$idx} if defined $c->{$idx};

  $c->{$idx} = (($_[0] % $_[1]) != 0 and ($_[1] % $_[0]) != 0) ? 1 : 0;

  return $c->{$idx};
}

sub nCuteLists {
  my $n = 0;
  my $m = 0;
  my $p = Algorithm::Permute->new([1 .. $_[0]]);
  while (my @l = $p->next) {
    $m++;
    my $i = 1;
    $n++ if ((firstidx { isCuteEntry($l[$i-1],$i++) } @l) == -1);
  }

  return "$n / $m";
}

# Note, testing up to 12 because of time lengthy

for (1..12) {
  my $t0 = [gettimeofday];
  printf "nCuteLists($_) = %s (in %f seconds)\n", nCuteLists($_), tv_interval ($t0);
}
