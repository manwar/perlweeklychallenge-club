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

my %d;
my @t=([0,0]);
while (@t) {
  my $i=shift @t;
  my ($index,$depth)=@{$i};
  push @{$d{$depth}},$index;
  if (exists $tree{$index}{children}) {
    push @t,map {[$_,$depth+1]} @{$tree{$index}{children}};
  }
}

my %c;
my @out;
my $d=max(keys %d);
while (1) {
  my @r;
  if (@out) {
    foreach my $i (0..$#{$d{$d}}) {
      my $si=$tree{$d{$d}[$i]}{children}[0] or die "need a full tree";
      $r[$i]=$c{$si}+2;
    }
  } else {
    my $noffsets=scalar @{$d{$d}};
    my $j=-2;
    while ($noffsets) {
      $j+=2;
      push @r,$j;
      $j+=4;
      push @r,$j;
      $noffsets-=2;
    }
  }
  my $str=' ' x (max @r);
  my $stru=' ' x ((max @r)-1);
  my $m=0;
  foreach my $i (0..$#{$d{$d}}) {
    substr($str,$r[$i],1)=$tree{$d{$d}[$i]}{value};
    $c{$d{$d}[$i]}=$r[$i];
    unless ($d==0) {
      if ($m%2==0) {
        substr($stru,$r[$i]+1,1)='/';
      } else {
        substr($stru,$r[$i]-1,1)='\\';
      }
      $m++;
    }
  }
  unshift @out,$str;
  if ($d>0) {
    unshift @out,$stru;
  }
  if ($d==0) {
    last;
  }
  $d--;
}

print map {"$_\n"} @out;
