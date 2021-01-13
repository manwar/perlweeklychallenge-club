#!/usr/bin/env raku

sub isomorphic-strings ($a, $b) {
    $b eq $a.trans: $a => $b
    and
    $a eq $b.trans: $b => $a
}

multi MAIN (Str $a, Str $b) {
    say +isomorphic-strings $a, $b
}

multi MAIN (Bool :$test!) {
    use Test;
    is isomorphic-strings('abc','xyz'), True;
    is isomorphic-strings('abb','xyy'), True;
    is isomorphic-strings('sum','add'), False;
    is isomorphic-strings('add','sum'), False;
    is isomorphic-strings($_ ,.trans('a'..'z' => ('b'..'z','a')) ), True for <isomorphic strings>;
    done-testing;
}
