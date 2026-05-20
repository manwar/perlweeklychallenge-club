#!/bin/env raku

unit sub MAIN(Str:D $str);

put (^$str.chars).combinations(2).map(-> (\from,\to) {
    with $str.substr(from, to - from + 1) {
        $_ if .comb.all eq <a e i o u>.any and .contains(<a e i o u>.all)
    }
}).gist;
