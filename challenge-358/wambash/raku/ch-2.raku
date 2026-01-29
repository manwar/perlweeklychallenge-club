#!/usr/bin/env raku
use v6.e.PREVIEW;

sub encrypted-string (+$str, :$int = 13) {
    $str
    andthen .ords
    andthen .map: { (($_ - 'a'.ord + $int) mod 26) + 'a'.ord }\
    andthen .chrs
}

multi MAIN (Bool :test($)!) {
    use Test;
    is encrypted-string('abc',:1int), 'bcd';
    is encrypted-string('xyz',:2int), 'zab';
    is encrypted-string('abc',:27int), 'bcd';
    is encrypted-string('hello',:5int), 'mjqqt';
    is encrypted-string('hello',:3int), 'khoor';
    is encrypted-string('perl',:26int), 'perl';
    is encrypted-string('perl'), 'crey';
    done-testing;
}

multi MAIN ($str, :$int = 13) {
    say encrypted-string $str, :$int;
}
