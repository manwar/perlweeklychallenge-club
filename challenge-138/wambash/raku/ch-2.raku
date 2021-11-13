#!/usr/bin/env raku

sub split-number ($n) {
    1 ..^ $n.chars
    andthen .combinations
    andthen .map: {0, |$_, $n.chars}\
    andthen .map: { .skip Z- $_ }\
    andthen .skip
    andthen .map: { $n.comb.rotor($_) }\
    andthen .tree: *.Seq, *.sum, *.join
    andthen .first: {$_² == $n}, :p
}

multi MAIN (Bool :test($)!) {
    use Test;
    is split-number(9801), 1=> 99;
    is split-number(81), 0 => 9;
    is split-number(36),  Nil;
    done-testing;
}

multi MAIN ($n) {
    say +so split-number $n
}
