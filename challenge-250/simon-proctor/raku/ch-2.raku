#!/usr/bin/env raku

multi sub MAIN('test') {
    use Test;
    is alpha-string("perl"), 4;
    is alpha-string("2"),2;
    is alpha-string("000"),0;
    is alpha-string("python"),6;
    is alpha-string("r4ku"),4;
    is alpha-string("001"),1;
    is alpha-string("1"),1;
    is alpha-string("000"),0;
    is alpha-string("0001"),1;
    is max-alpha("perl", "2", "000", "python", "r4ku"),6;
    is max-alpha("001", "1", "000", "0001"), 1;
    done-testing;
}

multi sub MAIN(*@vals) {
    max-alpha(|@vals).say;
}

sub alpha-string($v) {
    $v ~~ /^ \d+ $/ ?? $v.Int !! $v.codes;
}

sub max-alpha(*@vals) {
    @vals.map({alpha-string($_)}).max;
}
