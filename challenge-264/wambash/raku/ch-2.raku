#!/usr/bin/env raku

sub target-array-reducer (@acc,$ (:key($where),:value($what))) {
    |@acc.head($where), $what, |@acc.skip($where)
}

multi target-array (@source,@indices) {
    @indices Z=> @source
    andthen (), |$_
    andthen .reduce: &target-array-reducer
}

multi MAIN (Bool :test($)!) {
    use Test;
    is target-array-reducer((), 0 => 1),(1,);
    is target-array-reducer((0, 1, 3, 2), 1 => 4), (0, 4, 1, 3, 2) ;
    is target-array(0..4, (0,1,2,2,1)),(0,4,1,3,2);
    is target-array((1,2,3,4,0), (0, 1, 2, 3, 0)),0..4;
    is target-array((1,), (0,)), (1,);
    done-testing;
}

multi MAIN ($source,$indices) {
    put target-array $source.split(q{,}),$indices.split(q{,})
}
