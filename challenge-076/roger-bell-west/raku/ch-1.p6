#! /usr/bin/perl6

use Test;

plan 1;

is(psum(9),2,"example");

sub psum($n) {
  my @p=reverse grep {is-prime($_)}, (2..$n);
  my @s=grep {sum(@($_))==$n}, @p.combinations(1..@p.elems);
  return @s[0].elems;
}
