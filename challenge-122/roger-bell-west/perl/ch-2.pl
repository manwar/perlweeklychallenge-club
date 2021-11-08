#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is_deeply(bp(4),[
  [1,1,1,1],
  [1,1,2],
  [1,2,1],
  [1,3],
  [2,1,1],
  [2,2],
  [3,1],
    ],'example 1');

is_deeply(bp(5),[
  [1,1,1,1,1],
  [1,1,1,2],
  [1,1,2,1],
  [1,1,3],
  [1,2,1,1],
  [1,2,2],
  [1,3,1],
  [2,1,1,1],
  [2,1,2],
  [2,2,1],
  [2,3],
  [3,1,1],
  [3,2],
  ],'example 2');

use List::Util qw(sum0 min);

sub bp {
  my $n=shift;
  my @o;
  my @p=([]);
  while (my $s=pop @p) {
    my $t=sum0(@{$s});
    if ($t==$n) {
      push @o,$s;
    } else {
      foreach my $i (1..min(3,$n-$t)) {
        push @p,[@{$s},$i];
      }
    }
  }
  @o=reverse @o;
  return \@o;
}
