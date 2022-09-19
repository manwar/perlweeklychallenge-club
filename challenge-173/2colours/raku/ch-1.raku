#!/usr/bin/env raku


subset Digit of Int where *.chars == 1;

sub infix:<nN>(Digit() $a, Digit() $b) is assoc<chain> {
  abs($a - $b) == 1
}

my $n = prompt 'Input: ';
say [nN] $n.comb;
