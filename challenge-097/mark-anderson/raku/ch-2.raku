#!/usr/bin/env raku

use Test;
plan 4;

is flips("101100101",        3), 1;
is flips("10110111",         4), 2;
is flips("1111000010101100", 2), 8; 
is flips("1111000010101100", 4), 8; 

sub flips($B, $S) 
{ 
    my ($head, @tail) = $B.comb: $S;

    .elems given flat @tail.map({ ("0b$head" +^ "0b$_").base(2).comb("1") });
}
