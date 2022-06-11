#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(planloot([2, 4, 5]),7,'example 1');

is(planloot([4, 2, 3, 6, 5, 3]),13,'example 2');

use List::Util qw(sum max);

sub planloot {
  my $houses = shift;
  my $terminal=scalar @{$houses}-2;
  my @b=([0]);
  my $reward=0;
  while (scalar @b > 0) {
    my $c=pop @b;
    if ($c->[-1] >= $terminal) {
      $reward=max($reward,sum(map {$houses->[$_]} @{$c}));
    } else {
      foreach my $n ($c->[-1]+2..$c->[-1]+3) {
        if ($n >= scalar @{$houses}) {
          last;
        }
        push @b,[@{$c},$n];
      }
    }
  }
  return $reward;
}
