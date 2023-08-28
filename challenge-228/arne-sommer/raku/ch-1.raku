#! /usr/bin/env raku

unit sub MAIN (*@int where @int.elems > 0 && all(@int) ~~ Int);

say @int.Bag.grep( *.value == 1 ).map( *.key ).sum;
