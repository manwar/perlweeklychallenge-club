#!/usr/bin/env raku

sub completing-word (+str,:$str) {
    my %letters := $str.lc.comb(/<alpha>/).Bag;

    str
    andthen .grep: { .comb.Bag ⊇ %letters }\
    andthen .min: *.chars
}

multi MAIN (Bool :test($)!) {
    use Test;
    is completing-word(<accbbb abc abbc>,:str('aBc 11c')),'accbbb';
    is completing-word('abcm', 'baacd', 'abaadc',:str('Da2 abc')),'baacd';
    is completing-word('jj', 'bb', 'bjb',:str('JB 007')),'bjb';
    done-testing;
}

multi MAIN (+str,:$str) {
    say completing-word +str,:$str
}
