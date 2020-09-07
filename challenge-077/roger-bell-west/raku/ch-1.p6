#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(psum(6),[(1,5),(1,2,3)],"example 6-2");
is-deeply(psum(9),[(1,8),(1,3,5)],"example 9-2");

sub psum($n) {
  my @p=(1,1);
  while (@p[@p.end] < $n) {
    push @p,@p[@p.end]+@p[@p.end-1];
  }
  shift @p;
  my @o=grep {sum(@($_))==$n}, @p.combinations(1..@p.elems);
  return @o;
}
