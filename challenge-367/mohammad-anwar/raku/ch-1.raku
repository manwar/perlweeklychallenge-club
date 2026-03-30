#!/usr/bin/env raku

use Test;

my @examples = [
    [ "1011",   "1101"   ],
    [ "100",    "001"    ],
    [ "111000", "110001" ],
    [ "0101",   "1001"   ],
    [ "1111",   "1111"   ],
];

for @examples -> $ex {
    is max-odd-binary($ex[0]), $ex[1];
}

done-testing;

sub max-odd-binary($str) {
    my $c1 = $str.comb('1').elems;
    my $c0 = $str.comb('0').elems;

    return "1" x ($c1 - 1) ~ "0" x $c0 ~ "1";
}
