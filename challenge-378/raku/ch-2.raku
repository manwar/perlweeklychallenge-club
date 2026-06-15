#!/usr/bin/env raku


subset IsTrue of Bool where so *;

multi sub MAIN( IsTrue :t(:$test) ) is hidden-from-USAGE {
    use Test;
    is str-to-int("acb"),21;
    is str-to-int("cba"),210;
    is str-to-int("cdb"),231;
    ok check-sum("acb","cba","cdb");
    ok check-sum("aab","aac","ad");
    nok check-sum("bc","je","jg");
    ok check-sum("a","aaaa","aa");
    nok check-sum("c","d","h");
    ok check-sum("gfi","hbf","bdhd");
    done-testing;
}

subset AToJStr of Str where /^ <[a..j]>+ $/;

sub str-to-int( AToJStr $str ) {
    my $map = "abcdefghij";
    $str.comb(/./).map({$map.index($_)}).join('').Int;
}

sub check-sum( AToJStr $str1, AToJStr $str2, AToJStr $str3 ) {
    return str-to-int($str1) + str-to-int($str2) == str-to-int($str3);
}

#|(
You are given three strings consisting of lower case English letters ‘a’ to ‘j’ only. The letter value of a = 0, b = 1, c = 3, etc.

Write a script to find if sum of first two strings return the third string.
)
multi sub MAIN( AToJStr $str1, AToJStr $str2, AToJStr $str3 ) {
    check-sum($str1, $str2, $str3).say;
}

