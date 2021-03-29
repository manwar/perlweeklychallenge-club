#!/usr/bin/env raku

sub nth-root-newton ($k, $n=2) {
    $k, { $_ * (1 -  1/ $n) +$k/( $n*$_**($n-1) ) } ... * **$n  =~= $k 
    andthen .tail                                              
}

multi MAIN (Bool :$test!) {
    use Test;
    is-approx nth-root-newton(4), 2;
    is-approx nth-root-newton(248832,5), 12;
    subtest {
        my  $*TOLERANCE=0.01;
        is-approx nth-root-newton(126), sqrt(126), :rel-tol($*TOLERANCE);
        is-approx nth-root-newton(34,5),   2.02,   :rel-tol($*TOLERANCE);
        is-approx nth-root-newton(4.FatRat),  2,   :rel-tol($*TOLERANCE);
        is-approx nth-root-newton(248832,5), 12,   :rel-tol($*TOLERANCE);
        done-testing
    } 
    done-testing
}

multi MAIN ($k, $n=2) {
    my  $*TOLERANCE=1e-14;
    say nth-root-newton $k, $n
}
