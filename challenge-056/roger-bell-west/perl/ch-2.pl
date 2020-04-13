#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

my @tree=qw(5 .4 ..11 ...7 ...2 .8 ..13 ..9 ...1);
#           0  1    2    3    4  5    6   7    8

my $target=22;

my %tree;
{
  my @parent;
  foreach my $index (0..$#tree) {
    $tree[$index] =~ /^(\.*)(\d+)/;
    my ($depth,$val)=(length($1),$2);
    $tree{$index}{value}=$val;
    if ($depth>0) {
      push @{$tree{$parent[$depth-1]}{children}},$index;
    }
    $parent[$depth]=$index;
  }
}

my @paths=([0]);
while (@paths) {
  my $p=shift @paths;
  if (exists $tree{$p->[-1]}{children}) {
    foreach my $x (@{$tree{$p->[-1]}{children}}) {
      push @paths,[@{$p},$x];
    }
  } else {
    if (sum(map{$tree{$_}{value}} @{$p}) == $target) {
      print join(' -> ',map{$tree{$_}{value}} @{$p}),"\n";
    }
  }
}
