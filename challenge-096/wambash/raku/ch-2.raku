#!/usr/bin/env raku

multi edit-distance-iter ( @a, @b where :!elems, :$distance = 0, ) {
    \( Empty,Empty, distance => $distance + @a.elems, :end )
}

multi edit-distance-iter ( @a where :!elems, @b, :$distance = 0, ) {
    \( Empty,Empty, distance => $distance + @b.elems, :end )
}

multi edit-distance-iter ( @a, @b,    :$distance = 0, ) {
    (
    \(@a.skip($_), @b,          distance => $distance + $_ )  with @a.first(* eqv @b.head,:k);
    \(@a,          @b.skip($_), distance => $distance + $_ )  with @b.first(* eqv @a.head,:k);
    \(@a.skip,     @b.skip,     distance => $distance + 1);
    )
}

multi edit-distance-iter ( @a, @b where { (@a.head eqv @b.head)}, :$distance = 0 ) {
    \(@a.skip, @b.skip, :$distance )
}

multi edit-distance-iter ( Capture $c ) {
    edit-distance-iter |$c
}

multi edit-distance-iter ( @a ) {
    (slip(edit-distance-iter @a.head), |@a.skip).sort(*.<distance>)
}

multi edit-distance (@a,@b, :$distance = 0 ) {
    [\(@a,@b, :$distance),], *.&edit-distance-iter ... *.cache.head.<end>
    andthen .tail.head.<distance>
}

multi MAIN ( $a, $b ) {
    say edit-distance $a.comb, $b.comb
}

multi MAIN (Bool :$test!) {
    use Test;
    is edit-distance-iter('1234'.comb, Empty).<distance>, 4;
    is edit-distance-iter('1234'.comb, Empty).<end>, True;
    is edit-distance-iter(Empty, '12345'.comb).<distance>, 5;
    is edit-distance-iter(Empty, Empty).<distance>, 0;
    is edit-distance-iter(edit-distance-iter('1234'.comb,'122'.comb)).[1],2;
    is edit-distance( 1234.comb, 34561.comb), 5;
    is edit-distance(1234.comb, 1234.comb), 0;
    is edit-distance('kitten'.comb, 'sitting'.comb),3;
    is edit-distance('sunday'.comb,'monday'.comb),2;
    done-testing;
}
