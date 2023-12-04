#! /usr/bin/raku

use Test;

plan 2;

is-deeply(sortlanguage(['perl', 'c', 'python'], [2, 1, 3]), ['c', 'perl', 'python'], 'example 1');
is-deeply(sortlanguage(['c++', 'haskell', 'java'], [1, 3, 2]), ['c++', 'java', 'haskell'], 'example 2');

sub sortlanguage(@langs, @popularities) {
    my @ix = [0 .. @langs.end].sort({@popularities[$^a] <=> @popularities[$^b]});
    return Array(@ix.map({@langs[$_]}));
}
