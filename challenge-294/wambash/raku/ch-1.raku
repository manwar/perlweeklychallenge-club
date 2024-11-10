#!/usr/bin/env raku
use v6.e.*;

sub consecutive-sequence-iter ( (Set() $ints, :$max =0) ) {
    $ints.keys.min, { $ints{$_+1}:k } ... {!$ints{$_}}\
    andthen .Set
    andthen \( $ints (-) $_, max => $max max $_.elems )
}

multi consecutive-sequence (+ints, :$max=0) {
    \(ints.Set, :$max), &consecutive-sequence-iter ... !*.head.elems
    andthen .tail.<max>
}


multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply consecutive-sequence-iter( \(set(10, 4, 20, 1, 3, 2))), \(set(10,20), :4max);
    is-deeply consecutive-sequence-iter( \(set(10, 20), :4max)), \(set(20), :4max);
    is-deeply consecutive-sequence-iter( \(set(20), :4max)), \(set(), :4max);
    is-deeply consecutive-sequence(10, 4, 20, 1, 3, 2), 4;
    is-deeply consecutive-sequence(0, 6, 1, 8, 5, 2, 4, 3, 0, 7), 9;
    is-deeply consecutive-sequence(10,20), 1;
    is-deeply consecutive-sequence(), 0;
    is-deeply consecutive-sequence(0, 6, 1, 8, 5,-10, 2,-20, 4, 3, 0, 7), 9;
    done-testing;
}

multi MAIN (+ints) {
    say consecutive-sequence ints».Int
}
