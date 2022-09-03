#! /usr/bin/env raku

unit sub MAIN (Int $i, *@n where @n.elems > 0 && all(@n) ~~ Numeric);

say @n.grep: * > $i;


