#!/bin/env raku

unit sub MAIN(Str:D $name, Str:D $typed);

sub key-strokes(Str:D $str) {
    $str.comb(/(.)$0*/).map({ .substr(0,1) => .chars }).Array
}

put ?(key-strokes($name) Z key-strokes($typed)).map({ [(<=)] $_ }).all;
