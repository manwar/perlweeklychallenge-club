#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(mindepth(str2tree("1 | 2 3 | 4 5")),2,'example 1');

is(mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")),3,'example 2');

sub str2tree {
  my $st=shift;
  my @o;
  my $d=0;
  my $p=0;
  foreach my $e (split ' ',$st) {
    if ($e eq '|') {
      $d++;
      $p=0;
      my $m=(1<<($d+1))-1;
      if (scalar @o < $m) {
        push @o,(0) x ($m - scalar @o);
      }
    } else {
      my $y=0;
      if ($e ne '*') {
        $y=0+$e;
      }
      my $i=(1<<$d) -1 +$p;
      $o[$i]=$y;
      $p++;
    }
  }
  return \@o;
}

sub mindepth {
  my $tree = shift;
  my $firstleaf=scalar @{$tree};
  foreach my $i (0..$#{$tree}) {
    if ($tree->[$i]==0) {
      next;
    } elsif (($i+1) << 1 >= scalar @{$tree}) {
      $firstleaf=$i;
      last;
    } else {
      my $ni=(($i+1) << 1)-1;
      if ($tree->[$ni]==0 && $tree->[$ni+1]==0) {
        $firstleaf=$i;
        last;
      }
    }
  }
  my $t=$firstleaf+1;
  my $d=0;
  while ($t > 0) {
    $t >>= 1;
    $d++;
  }
  return $d;
}
