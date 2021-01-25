#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 2;

is(bs('101100101',3),1,'example 1');
is(bs('00011011',2),4,'example 2');

use List::Util qw(sum);

sub bs {
  my $b=shift;
  my $s=shift;
  my @bb=grep /./,split /(.{$s})/,$b;
  if (length($bb[-1]) != $s) {
    return -1;
  }
  my $mc;
  my %cost;
  foreach my $x (0..$#bb-1) {
    $cost{$x}{$x}=0;
    foreach my $y ($x+1..$#bb) {
      $cost{$x}{$y}=$cost{$y}{$x}=diff($bb[$x],$bb[$y]);
    }
    my $tc=sum(map {$cost{$x}{$_}} 0..$#bb);
    if (!defined $mc || $tc < $mc) {
      $mc=$tc;
    }
  }
  return $mc;
}

sub diff {
  my ($a,$b)=@_;
  my @ac=split '',$a;
  my @bc=split '',$b;
  my $d=0;
  foreach my $i (0..$#ac) {
    if ($ac[$i] ne $bc[$i]) {
      $d++;
    }
  }
  return $d;
}
