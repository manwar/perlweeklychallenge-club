#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 2;

is_deeply(mergeaccount([['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com', 'a1@a.com']]), [['A', 'a1@a.com', 'a2@a.com', 'a3@a.com'], ['B', 'b1@b.com']], 'example 1');
is_deeply(mergeaccount([['A', 'a1@a.com', 'a2@a.com'], ['B', 'b1@b.com'], ['A', 'a3@a.com'], ['B', 'b2@b.com', 'b1@b.com']]), [['A', 'a1@a.com', 'a2@a.com'], ['A', 'a3@a.com'], ['B', 'b1@b.com', 'b2@b.com']], 'example 2');

sub mergeaccount($a) {
  my @aname;
  my $id = 0;
  my %r;
  foreach my $acc (@{$a}) {
    push @aname, $acc->[0];
    foreach my $i (1..$#{$acc}) {
      push @{$r{$acc->[$i]}}, $id;
    }
    $id++;
  }
  my %m;
  foreach my $idlist (values %r) {
    if (scalar @{$idlist} > 1) {
      my $root = $idlist->[0];
      while (exists $m{$root}) {
        $root = $m{$root};
      }
      foreach my $i (1..$#{$idlist}) {
        $m{$idlist->[$i]} = $root;
      }
    }
  }
  my %staging;
  my %prefix;
  foreach my $id (0..$#{$a}) {
    my $ii = $id;
    while (exists $m{$ii}) {
      $ii = $m{$ii};
    }
    my $acc = $a->[$id];
    if (!exists $prefix{$ii}) {
      $prefix{$ii} = $acc->[0];
    }
    foreach my $addr (map {$acc->[$_]} 1..$#{$acc}) {
      $staging{$ii}{$addr} = 1;
    }
  }
  my @out;
  foreach my $k (keys %staging) {
    push @out,[$prefix{$k}, sort keys %{$staging{$k}}];
  }
  @out = sort {$::a->[0] cmp $::b->[0] ||
                 $::a->[1] cmp $::b->[1]} @out;
  return \@out;
}
