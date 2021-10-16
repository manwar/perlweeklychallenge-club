#!/usr/bin/env raku


sub pandigital-numbers($n=5) {
    1,0,slip 2..9
    andthen .permutations
    andthen .head($n)
    andthen .map: *.join
}


multi MAIN (Bool :test($)!) {
    use Test;
    is pandigital-numbers, <1023456789 1023456798 1023456879 1023456897 1023456978>;
    done-testing;
}

multi MAIN ($n=5) {
    .put for pandigital-numbers($n);
}
