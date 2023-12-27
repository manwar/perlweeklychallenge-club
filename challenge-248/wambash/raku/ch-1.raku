#!/usr/bin/env raku

sub shortest-distance-index ($index, $str, $char) {
    $str
    andthen .indices: $char
    andthen .map: { abs $_ - $index }\
    andthen .min
}

sub shortest-distance ($str, $char) {
    my $length = $str.chars;

    ^$length .map: *.&shortest-distance-index: $str, $char
}

multi MAIN (Bool :test($)!) {
    use Test;
    is shortest-distance-index(3,'loveleetcode','l'), 1;
    is shortest-distance-index(1,'loveleetcode','l'), 1;
    is shortest-distance-index(0,'loveleetcode','c'), 8;
    is shortest-distance-index(11,'loveleetcode','c'), 3;
    is shortest-distance('loveleetcode','e'), (3,2,1,0,1,0,0,1,2,2,1,0);
    is shortest-distance('aaab','b'), (3,2,1,0);
    done-testing;
}

multi MAIN ($str, $char) {
    say shortest-distance $str, $char
}
