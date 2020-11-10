#! /usr/bin/perl6

use Test;
plan 3;

is(pd((10, 8, 12, 15, 5),7),1,'example 1');
is(pd((1, 5, 2, 9, 7),6),1,'example 2');
is(pd((10, 30, 20, 50, 40),15),0,'example 3');

sub pd(@n,$a) {
  my $n=Set.new(@n);
  for map {$_+$a},$n.keys -> $p {
    if ($n{$p}:exists) {
      return 1;
    }
  }
  return 0;
}
