#!/usr/bin/env raku

sub over-two ($n) {
    $n * ($n -1) / 2
}

sub similar-words (+words) {
    words
    andthen .classify: *.comb.Set
    andthen .map: *.value.elems
    andthen .map: &over-two
    andthen .sum
}

multi MAIN (Bool :test($)!) {
    use Test;
    is similar-words('aba', 'aabb', 'abcd', 'bac', 'aabc'), 2;
    is similar-words(<aabb ab ba>), 3;
    is similar-words(<nba cba dba>), 0;
    done-testing;
}

multi MAIN (+words) {
    say similar-words words
}
