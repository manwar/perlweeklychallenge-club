#!/usr/bin/env raku

multi sub MAIN("TEST") is hidden-from-USAGE {
    use Test;
    is bit-flip(5), 2;
    is bit-flip(4), 3;
    is bit-flip(6), 1;
    is bit-flip(2), 1;
    is bit-flip(3), 0;
    is bit-flip(1), 0;  
    done-testing;
}

#| Given an Int $x find the binary flip of it
multi sub MAIN( IntStr $x ) {
    bit-flip($x).say;
}

sub bit-flip( Int() $x ) returns Int {  
    $x.base(2).comb().map( { abs($_-1) } ).join("").parse-base(2);
}
