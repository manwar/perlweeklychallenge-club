#!/usr/bin/env raku

sub broken-keyboard ($str, :$keys=()) {
    $str
    andthen .words
    andthen .grep: { !.contains: $keys.any,:i }\
    andthen .elems
}

multi MAIN (Bool :test($)!) {
    use Test;
    is broken-keyboard('Hello World', :keys<d> ), 1;
    is broken-keyboard('apple banana cherry', :keys<a e> ), 0;
    is broken-keyboard('Coding is fun', :keys() ), 3;
    is broken-keyboard('Coding is fun' ), 3;
    is broken-keyboard('The weekly challenge',:keys<a b> ), 2;
    is broken-keyboard('Perl and Python',:keys<p> ), 1;
    done-testing;
}

multi MAIN (+$str, :@keys) {
    say broken-keyboard ~$str, :@keys;
}
