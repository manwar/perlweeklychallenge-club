#! /usr/bin/perl6

use Test;
plan 4;

is(lychrel(56),0,'example 1');
is(lychrel(57),0,'example 2');
is(lychrel(59),0,'example 3');
is(lychrel(196),-1,'example 4');

sub lychrel($nn) {
  my $n=$nn;
  for (1..100) {
    my $m=$n.comb.reverse.join('');
    if ($m==$n) {
      return 0;
    }
    $n+=$m;
    if ($n>=10000000) {
      last;
    }
  }
  return -1;
}
