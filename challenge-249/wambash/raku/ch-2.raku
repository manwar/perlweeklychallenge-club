#!/usr/bin/env raku

enum DI <I D>;

multi DI-reducer ( @a, I, :&f=&take) {
    f @a.head;
    @a.skip
}

multi DI-reducer ( @a, D, :&f=&take) {
    f @a.tail;
    @a.head: * - 1
}

sub DI-string-match ($s) {
    my DI @si = |$s.comb.map( { DI::{$_} } ), I ;

    gather { reduce &DI-reducer, ^@si, |@si }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply DI-reducer((0,1,2,3), I, :f(&item)), (1,2,3);
    is-deeply DI-reducer((0,1,2,3), D, :f(&item)), (0,1,2);
    is-deeply gather { DI-reducer((0,1,2,3), D) }, (3,);
    is-deeply gather { DI-reducer((2,), I) }, (2,);
    is-deeply DI-string-match('IDID'), (0,4,1,3,2);
    is-deeply DI-string-match('III'), (0,1,2,3);
    is-deeply DI-string-match('DDI'), (3,2,0,1);
    is-deeply DI-string-match('ID' x 100).head(2), (0,200);
    done-testing;
}

multi MAIN ($s) {
    say DI-string-match $s
}
