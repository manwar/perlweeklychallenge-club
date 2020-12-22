#! /usr/bin/perl

use strict;
use warnings;

use Test::More tests => 3;

is(isos('abc','xyz'),1,'example 1');
is(isos('abb','xyy'),1,'example 2');
is(isos('sum','add'),0,'example 3');

sub isos {
  my @s=@_;
  if (length($s[0]) != length($s[1])) {
    return 0;
  }
  my @c=map {[split '',$_]} @s;
  my @lt=({},{});
  my @n=(0,0);
  foreach my $ci (0..$#{$c[0]}) {
    my @r;
    foreach my $si (0,1) {
      if (exists $lt[$si]{$c[$si][$ci]}) {
        push @r,$lt[$si]{$c[$si][$ci]};
      } else {
        $lt[$si]{$c[$si][$ci]}=$n[$si];
        push @r,$n[$si];
        $n[$si]++;
      }
    }
    if ($r[0] != $r[1]) {
      return 0;
    }
  }
  return 1;
}
