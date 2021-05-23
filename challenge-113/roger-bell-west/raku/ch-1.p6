#! /usr/bin/perl6

use Test;

plan 2;

is(ri(25,7),0,'example 1');
is(ri(24,7),1,'example 2');

sub ri($n,$d) {
  my @e=grep /$d/,(1..$n);
  for 1..1+<@e.elems-1 -> $i {
    my $s=0;
    for 0..@e.elems-1 -> $ii {
      if (1+<$ii +& $i) {
        $s+=@e[$ii];
      }
    }
    if ($s==$n) {
      return 1;
    }
  }
  return 0;
}
