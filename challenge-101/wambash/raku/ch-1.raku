#!/usr/bin/env raku

sub rotate-left (+@n) {
    @n[0].keys
    andthen .reverse
    andthen .map: { @n[*;$_] }\
}

sub reducer (@a,@b) {
    @a
    andthen .&rotate-left
    andthen @b, |$_
}

sub column-counter ($i) {
    sqrt($i).Int ... 1
    andthen .first: $i %% *
}

sub pack-a-spiral (+@a, :$n = column-counter(@a.elems), :$m = @a.elems div $n) {
    @a
    andthen .reverse                                   #to counterclockwise
    andthen .rotor: flat $m-$n ^.. $m Z, 1 .. $n
    andthen [[]], |$_
    andthen .reduce: &reducer
    andthen .&rotate-left.&rotate-left                 #top-right → bottom-left
}

multi MAIN (Bool :$test!) {
    use Test;
    is pack-a-spiral(1..12),   (<9 8 7 6>,  <10 11 12 5>, <1  2  3 4>);
    is pack-a-spiral(1.. 6),   (<6 5 4>, <1 2 3>);
    is pack-a-spiral(1,2,3,4), (<4 3>, <1 2>);
    done-testing;
}

multi MAIN ( *@a ) {
    put pack-a-spiral(@a).fmt: "%3s","\n";
}
