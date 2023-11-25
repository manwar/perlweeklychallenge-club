#! /usr/bin/env raku

unit sub MAIN (*@int where @int.elems > 0 && all(@int) ~~ Int);

say "(" ~ @int.map({ @int.grep( * < $_ ).elems }).join(", ") ~ ")";
