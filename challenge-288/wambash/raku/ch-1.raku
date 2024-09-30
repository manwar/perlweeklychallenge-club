#!/usr/bin/env raku

sub closest-palindrome (Int() $str) {
    $str, $str, -> $p, $n {slip $p.pred, $n.succ} ... *
    andthen .skip: 2
    andthen .first: { $_ == .flip}
}

multi MAIN (Bool :test($)!) {
    use Test;
    is closest-palindrome('123'), '121';
    is closest-palindrome('2'), '1';
    is closest-palindrome('1400'), '1441';
    is closest-palindrome('1001'), '999';
    done-testing;
}

multi MAIN ($str) {
    say closest-palindrome $str
}
