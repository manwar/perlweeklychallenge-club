#! /usr/bin/perl6

use Test;

plan 3;

is(isos('abc','xyz'),1,'example 1');
is(isos('abb','xyy'),1,'example 2');
is(isos('sum','add'),0,'example 3');

sub isos($a,$b) {
  my @s=($a,$b);
  if (chars(@s[0]) != chars(@s[1])) {
    return 0;
  }
  my @c=map {[$_.comb]},@s;
  my @lt=({},{});
  my @n=(0,0);
  for 0..@c[0].end -> $ci {
    my @r;
    for 0,1 -> $si {
      if (@lt[$si]{@c[$si][$ci]}:exists) {
        push @r,@lt[$si]{@c[$si][$ci]};
      } else {
        @lt[$si]{@c[$si][$ci]}=@n[$si];
        push @r,@n[$si];
        @n[$si]++;
      }
    }
    if (@r[0] != @r[1]) {
      return 0;
    }
  }
  return 1;
}
