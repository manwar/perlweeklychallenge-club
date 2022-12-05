#! /usr/bin/perl6

use Test;

plan 3;

is(frequencyequalizer("abbc"), True, 'example 1');
is(frequencyequalizer("xyzyyxz"), True, 'example 2');
is(frequencyequalizer("xzxz"), False, 'example 3');

sub frequencyequalizer($s) {
  my %f;
  for $s.comb -> $c {
    %f{$c}++;
  }
  my @v = %f.values.sort;
  if (@v[0] == @v[*-2] &&
      @v[0] + 1 == @v[*-1]) {
    return True;
  }
  return False;
}
