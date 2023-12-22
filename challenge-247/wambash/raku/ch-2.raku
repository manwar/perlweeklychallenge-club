#!/usr/bin/env raku
use v6.e.PREVIEW;

sub most-frequent-letter-pair ($s) {
    $s
    andthen .comb: 2 => -1
    andthen .Bag
    andthen .maxpairs
    andthen .map: *.key
    andthen .min
}

multi MAIN (Bool :test($)!) {
    use Test;
    is most-frequent-letter-pair('abcdbca'),'bc';
    is most-frequent-letter-pair('cdeabeabfcdfabgcd'),'ab';
    done-testing;
}

multi MAIN ($s) {
    say most-frequent-letter-pair $s
}
