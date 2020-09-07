#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);
use Algorithm::Combinatorics qw(combinations);

use Test::More tests => 2;

is_deeply(psum(6),[[1,5],[1,2,3]],"example 6");
is_deeply(psum(9),[[1,8],[1,3,5]],"example 9");

sub psum {
  my $n=shift;
  my @p=(1,1);
  while ($p[-1] < $n) {
    push @p,$p[-1]+$p[-2];
  }
  shift @p;
  my @o;
  foreach my $l (1..scalar @p) {
    foreach my $comb (combinations(\@p,$l)) {
      if (sum(@{$comb})==$n) {
        push @o,$comb;
      }
    }
  }
  return \@o;
}
