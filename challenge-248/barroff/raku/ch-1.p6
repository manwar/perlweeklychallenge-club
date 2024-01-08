#!/usr/bin/env raku

use v6.d;

sub minimal-distance(Int:D $start, @positions --> Int:D) {
    min(map({ abs($start - $_) }, @positions));
}

sub sd(Str:D $str, Str:D $char where $char.chars == 1 --> List) {
    my @indices = $str.indices($char);
    # return empty list if string does not contain searched character
    return () unless @indices;
    map({ $_ (elem) @indices
            ?? 0                              # index is character
            !! minimal-distance($_, @indices) # find closest index
        }, 0..$str.chars - 1
    ).list;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is sd('loveleetcode', 'e'), [3,2,1,0,1,0,0,1,2,2,1,0],
        'works for "e" in "loveleetcode"';
    is sd('aaab', 'b'), [3, 2, 1, 0],
        'works for "b" in "aaab"';
}

#| Take user provided list like aba aabb abcd bac aabc
multi sub MAIN(Str:D $str, Str:D $char) {
    say sd($str, $char);
}
