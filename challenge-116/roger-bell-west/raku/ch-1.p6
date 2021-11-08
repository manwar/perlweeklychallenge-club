#! /usr/bin/perl6

use Test;

plan 5;

is-deeply(ns(1234),[1,2,3,4],'example 1');
is-deeply(ns(91011),[9,10,11],'example 2');
is-deeply(ns(10203),[10203],'example 3');
is-deeply(ns(910911),[910,911],'example 4');
is-deeply(ns(9109119),[9109119],'example 5');

sub ns($n) {
  my $l=chars($n);
  for 1..floor($l/2) -> $sl {
    my $i=$sl;
    my @e=(substr($n,0,$sl))+0;
    while (1) {
      if ($l-$i == 0) {
        last;
      }
      push @e,@e[*-1]+1;
      my $el=chars(@e[*-1]);
      if ($l-$i < $el ||
            substr($n,$i,$el) ne @e[*-1]) {
        @e=();
        last;
      }
      $i+=$el;
    }
    if (@e) {
      return @e;
    }
  }
  return [$n];
}
