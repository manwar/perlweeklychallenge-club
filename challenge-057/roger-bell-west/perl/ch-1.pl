#! /usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

my @tree=qw(1 .2 ..4 ..5 .3 ..6 ..7);

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

foreach my $k (keys %tree) {
  if (exists $tree{$k}{children}) {
    @{$tree{$k}{children}}=reverse @{$tree{$k}{children}};
  }
}

tdump(\%tree,0,0);

sub tdump {
  my ($tree,$index,$depth)=@_;
  print '.' x $depth,$tree->{$index}{value},"\n";
  if (exists $tree->{$index}{children}) {
    foreach my $c (@{$tree->{$index}{children}}) {
      tdump($tree,$c,$depth+1);
    }
  }
}
