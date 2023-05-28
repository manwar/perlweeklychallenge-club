#! /usr/bin/env raku

unit sub MAIN (*@list where @list.elems >= 3 && all(@list) ~~ Int);

say @list.combinations(3)>>.reduce(&infix:<*>).max;
