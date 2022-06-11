#!/usr/bin/env raku

sub equilibrium-index (+@n) {
    @n.keys
    andthen .first: { @n[0..^$_].sum == @n[$_ ^.. *].sum }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is equilibrium-index(1, 3, 5, 7, 9), 3;
    is equilibrium-index(1, 2, 3, 4, 5), Nil;
    is equilibrium-index(2,4,2), 1;
    done-testing;
}

multi MAIN (*@n) {
    say equilibrium-index(@n) // -1
}
