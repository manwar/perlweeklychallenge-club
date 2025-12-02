#!/usr/bin/env raku

use Test;

my @examples = (
    %( in => "abcaefg", exp => 5 ),
    %( in => "xyzzabc", exp => 3 ),
    %( in => "aababc",  exp => 1 ),
    %( in => "qwerty",  exp => 4 ),
    %( in => "zzzaaa",  exp => 0 ),
);

for @examples -> %ex {
    is good-substring(%ex<in>), %ex<exp>;
}

done-testing;

sub good-substring(Str $str) {
    $str.comb.rotor(3 => -2).map(*.join).grep({!/(.).*$0/}).elems
}
