#!/usr/bin/env raku

sub is-hexadecimal-word ($s) {
    $s
    andthen .lc
    andthen .trans: 'olist' => '01157'
    andthen ? .parse-base: 16
}

multi MAIN (Bool :test($)!) {
    use Test;
    is is-hexadecimal-word('food'), True;
    is is-hexadecimal-word('frodo'), False;
    done-testing;
}

multi MAIN ($dict-file = '../../../data/dictionary.txt') {
    $dict-file.IO
    andthen Supply.from-list: .lines
    andthen .grep: 2 ≤ *.chars ≤ 8
    andthen .grep: &is-hexadecimal-word
    andthen .tap: &put
}
