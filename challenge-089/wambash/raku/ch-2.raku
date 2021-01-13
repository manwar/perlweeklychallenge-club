#!/usr/bin/env raku

sub make-matrix15 ( +@ (\a, \b, \d, \e) ) {
    my \c= 15 - (a+b);
    my \f= 15 - (d+e);
    my \g= 15 - (a+d);
    my \h= 15 - (b+e);
    my \i= 15 - (c+f); #=15- (g+h);

    (
        a, b, c;
        d, e, f;
        g, h, i;
    )
}

sub is-matrix15-magical ( @ (*@m) ) { @m.Set eqv set(1..9)}

multi MAIN () {
    1..9
    andthen .combinations(4).pick(*)
    andthen .map:  |*.permutations.pick(*)
    andthen .map:   &make-matrix15
    andthen .first: &is-matrix15-magical
    andthen .fmt('%s', "\n")
    andthen .say
}

multi MAIN ( Bool :$test! ) {
    use Test;
    my @magical := (
        5,3,7;
        1,8,6;
        9,4,2;
    );
    my @not-magical := (
        5,3,7;
        8,6,1;
        2,6,7;
    );
    ok  is-matrix15-magical @magical;
    nok is-matrix15-magical @not-magical;
    is-deeply make-matrix15(5,3,1,8), @magical;
    is-deeply make-matrix15(5,3,8,6), @not-magical;
    ok  is-matrix15-magical make-matrix15 8,1,4,9;
    nok is-matrix15-magical make-matrix15 8,1,4,3;
    done-testing;
}
