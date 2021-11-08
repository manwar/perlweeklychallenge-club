#!/usr/bin/env raku


sub consecutive-arrays (+@a) {
    @a
    andthen \(pre => Empty), |@a, any()
    andthen .produce: -> $a, $b {
        $a.<pre>.tail eqv $b.pred ?? \(pre => (|$a.<pre>,$b)) !! \( |$a.<pre>, pre => ($b) )
    }\
    andthen .map: *.List
    andthen .grep:  * !~~ Empty
}

multi MAIN (*@a) {
    say consecutive-arrays @a.map: *.Int;
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply consecutive-arrays(1,2,3,6,7,8,9), ((1,2,3),(6,7,8,9));
    is-deeply consecutive-arrays(11,12,14,17,18,19), ((11,12),(14,),(17,18,19));
    is-deeply consecutive-arrays(2,4,6,8), ((2,),(4,),(6,),(8,));
    is-deeply consecutive-arrays(1,2,3,4,5), ((1,2,3,4,5),);
    is-deeply consecutive-arrays(1,3,4,5,6,8,9,10),((1,),(3,4,5,6),(8,9,10));
    my @infinite-seq = ^Inf .grep: * !%% 4;
    is-deeply consecutive-arrays(@infinite-seq).head(3),((1,2,3),(5,6,7),(9,10,11));
    done-testing;
}
