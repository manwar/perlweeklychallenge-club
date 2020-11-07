#!/usr/bin/env raku

sub triplet-sum (+@r, Range :$range = 1..2) {
    @r
    andthen .pairs
    andthen .first: { @r[0 ..^ .key].any + .value + @r[.key ^.. *].any ~~ $range }
}

multi MAIN (Bool :$test!) {
    use Test;
    is triplet-sum( 1.2, 0.4, 0.1, 2.5, ), 1 => 0.4;
    is triplet-sum( 0.2, 1.5, 0.9, 1.1, ), Nil;
    is triplet-sum( 0.5, 1.1, 0.3, 0.7, ), 1 => 1.1;
    is triplet-sum( 0.5, 1.9, 0.3, 0.7, ), 2 => 0.3;
    done-testing;
}

multi MAIN (*@r) {
    say +so triplet-sum @r
}
