#!/usr/bin/env raku

sub count-asterisks ($str) {
    $str
    andthen .split: /<[|]> ~ <[|]> <-[|]>* /
    andthen .comb: '*'
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is count-asterisks('p|*e*rl|w**e|*ekly|'),2;
    is count-asterisks('perl'),0;
    is count-asterisks('th|ewe|e**|k|l***ych|alleng|e'),5;
    done-testing;
}

multi MAIN ($str) {
    say count-asterisks $str
}
