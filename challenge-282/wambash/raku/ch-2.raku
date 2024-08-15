#!/usr/bin/env raku

sub changing-keys ($str) {
    $str.fc
    andthen .comb: / (.) $0* /
    andthen .elems - 1
}

multi MAIN (Bool :test($)!) {
    use Test;
    is changing-keys('pPeERrLl'), 3;
    is changing-keys('rRr'),      0;
    is changing-keys('GoO'),      1;
    done-testing;
}

multi MAIN ($str) {
    say changing-keys $str
}
