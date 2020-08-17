#! /usr/bin/perl6

use Test;

plan 2;

is(fnr('ababc'),
   'abb#c',
   "example 1");
is(fnr('xyzzyx'),
   'xyzyx#',
   "example 2");

sub fnr($in) {
  my %s;
  my @s;
  my @o;
  for $in.comb -> $c {
    push @s,$c;
    %s{$c}++;
    @s=grep {%s{$_} < 2},@s;
    if (@s) {
      push @o,@s[@s.end];
    } else {
      push @o,'#';
    }
  }
  return join('',@o);
}
