#!/usr/bin/env raku

sub flip-array (+@a) {
    my $sum = @a.sum;
    @a.keys
    andthen .combinations
    andthen .min: { ( $sum - 2*@a[|$_].sum ) mod (4*$sum)  }\
    andthen .elems
}

multi MAIN ( Bool :$test! ) {
    use Test;
    is flip-array(3,10,8), 1;
    is flip-array(12,2,10), 1;
    is flip-array(10,2,12), 1;
    done-testing;
}

multi MAIN (**@a) {
    say flip-array @a;
}
