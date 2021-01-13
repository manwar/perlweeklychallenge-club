#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 5;

is(isinterleave(qw(XY X XXY)),1,'example 1');
is(isinterleave(qw(XXY XXZ XXXXZY)),1,'example 2');
is(isinterleave(qw(YX X XXY)),0,'example 3');
is(isinterleave(qw(ACF BDEG ABCDEFG)),1,'example 4');
is(isinterleave(qw(ACF BDGE ABCDEFG)),0,'example 5');

sub isinterleave {
  my ($a,$b,$c)=@_;
  my @s=(map {[split '',$_]} ($a,$b,$c));
  my @l=map {$#{$_}} @s;
  my @buf=([0,0,0]);
  while (@buf) {
    my $n=shift @buf;
    if ($n->[2] > $l[2]) {
      return 1;
    }
    if ($n->[0] <= $l[0] && $s[0][$n->[0]] eq $s[2][$n->[2]]) {
      push @buf,[$n->[0]+1,$n->[1],$n->[2]+1];
    }
    if ($n->[1] <= $l[1] && $s[1][$n->[1]] eq $s[2][$n->[2]]) {
      push @buf,[$n->[0],$n->[1]+1,$n->[2]+1];
    }
  }
  return 0;
}
