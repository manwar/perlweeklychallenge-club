#! /usr/bin/perl6

use Test;

plan 3;

is(pti(8),1,'example 1');
is(pti(15),0,'example 2');
is(pti(125),1,'example 3');

sub pti(Int $n) {
  my $l=log($n);
  for (2..floor(sqrt($n))) -> $ca {
    my $bg=floor($l/log($ca));
    for ($bg,$bg+1) -> $cb {
      if ($ca ** $cb == $n) {
        return 1;
      }
    }
  }
  return 0;
}
