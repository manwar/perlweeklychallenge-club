#!/usr/bin/env raku

sub group-position ($str) {
    $str.comb: /(\w) $0 ** 2..* /
}

multi MAIN (Bool :test($)!) {
    use Test;
    is group-position('abccccd'),<cccc>;
    is group-position('aaabcddddeefff'),<aaa dddd fff>;
    is group-position('abcdd'),Empty;
    done-testing;
}

multi MAIN ($str) {
    put group-position $str
}
