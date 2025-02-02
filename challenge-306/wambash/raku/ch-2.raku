#!/usr/bin/env raku
use v6e.PREVIEW;

sub max-rest (+@a) {
    my ($ind,$max) = @a.max: :kv;
    $max, @a.skip: $ind, 1
}

sub next-element (@ints) {
    my ($max, $rest) =  max-rest @ints;
    my ($max2, $rest2) = max-rest $rest;

    $max-$max2 || Empty, |$rest2
}

sub last-element (+ints) {
    ints, &next-element ... *.elems ≤ 1
    andthen .tail.head // 0
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply max-rest(1,2,3,2,1), (3,(1,2,2,1).Seq);
    is-deeply max-rest(1,2,2,1), (2,(1,2,1).Seq);
    is-deeply next-element((3, 8, 5, 2, 9, 2)), (1,3,5,2,2);
    is-deeply last-element(3, 8, 5, 2, 9, 2),1;
    is-deeply last-element(3, 2, 5),0;
    done-testing;
}

multi MAIN (+ints) {
    say last-element ints
}
