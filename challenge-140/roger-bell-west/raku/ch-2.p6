#! /usr/bin/perl6

use Test;

plan 2;

is(mtable(2,3,4),3,'example 1');
is(mtable(3,3,6),4,'example 2');

sub mtable($i,$j,$k) {
  my @l;
  for (1..$i) -> $a {
    push @l,map {$a*$_}, (1..$j);
  }
  @l=@l».List.flat.sort;
  return @l[$k-1];
}
