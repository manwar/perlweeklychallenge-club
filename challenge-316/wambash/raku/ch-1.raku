#!/usr/bin/env raku

sub circular (+list) {
    list
    andthen .rotor: 2 => -1
    andthen .map: {  .head.ends-with: .tail().comb.head }\
    andthen [and] $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is circular(<perl loves scala>),True;
    is circular(<love the programming>),False;
    is circular(<java awk kotlin node.js>),True;
    done-testing;
}

multi MAIN (+list) {
    say circular list
}
