#!/usr/bin/env raku

use v6;

multi sub MAIN("test") is hidden-from-USAGE {
    use Test;
    is( hash-count(1), "#", 1 );
    is( hash-count(2), "2#", 2 );
    is( hash-count(3), "#3#", 3 );
    is( hash-count(10), "#3#5#7#10#", 10 );
    is( hash-count(14), '2#4#6#8#11#14#', 14 );
    done-testing;
}

#| Returns the hash count string of the length x
multi sub MAIN(UInt \x) {
    hash-count(x).say;
}

multi sub hash-count(1) { "#" }
multi sub hash-count(0) { "" }
multi sub hash-count(UInt $x) {
    hash-count($x - ($x.chars + 1) ) ~ $x ~ '#';
}
