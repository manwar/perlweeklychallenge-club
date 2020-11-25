#! /usr/bin/perl6

use Test;

plan 2;

is-deeply(aop((5, 2, 1, 4, 3)),(24, 60, 120, 30, 40),'example 1');
is-deeply(aop((2, 1, 4, 3)),(12, 24, 6, 8),'example 2');

sub aop(@ns) {
  my $p=@ns.reduce: &infix:<*>;
  return (map {$p div $_}, @ns);
}
