#!/usr/bin/env raku

constant @fib = 1, 2, * + * ... *;

multi fibonacci-sequence(Int $n) {
    @fib.toggle: * ≤ $n
    andthen .reverse
    andthen (\(:$n, :c($_), u => Empty),), { .map: *.&fibonacci-sequence} ... *.cache.all.<n> == 0
    andthen .tail
}

multi fibonacci-sequence ( Capture $cap (:c(@), :u(@), :n($) where * == 0 ) ) {
    $cap
}


multi fibonacci-sequence ( Capture  (:u(@), :@c,:$n  where  @c.sum < $n  ) ) {
    Empty
}

multi fibonacci-sequence ( Capture (:$n, :c(@) where *.elems == 1, :@u) ) {
    \( n => $n - 1, u => ( |@u, 1 ), c => Empty)
}

multi fibonacci-sequence ( Capture ( :$n, :@c, :@u ) ) {
    @c, @c.skip.cache
    andthen |.map: { \( n => $n - .head, c => .skip.toggle( :off, * ≤ $n - .head ) ,  u => (|@u, .head) ) }\
}



multi MAIN (Bool :test($)!) {
    use Test;
    is fibonacci-sequence(16).elems, 4;
    is fibonacci-sequence(15).elems, 2;
    is fibonacci-sequence( 9).elems, 2;
    is-deeply fibonacci-sequence( 9).map( *.<u>), ((8,1),(5,3,1));
    is-deeply fibonacci-sequence(15).map( *.<u>), ((13,2),(8,5,2));
    done-testing;
}

multi MAIN (Int $n) {
    say fibonacci-sequence($n).elems
}
