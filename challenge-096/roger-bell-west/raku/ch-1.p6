#! /usr/bin/perl6

use Test;

plan 2;

is(rw('The Weekly Challenge'),'Challenge Weekly The','example 1');
is(rw('    Perl and   Raku are  part of the same family  '),'family same the of part are Raku and Perl','example 2');

sub rw($n) {
  return $n.comb(/\S+/).reverse.join(' ');
}
