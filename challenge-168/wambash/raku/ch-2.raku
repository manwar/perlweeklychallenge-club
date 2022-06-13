#!/usr/bin/env raku
use Prime::Factor;

sub home-prime ($n) {
    $n, {[~] prime-factors $_} ...^ * == *
}

multi MAIN (Bool :test($)!) {
    use Test;
    is home-prime(10).tail, 773;
    is home-prime(10), <10 25 55 511 773>;
    is home-prime( 8).tail, 3331113965338635107;
    done-testing;
}

multi MAIN ($n, Bool :s(:$steps) where *.so ) {
     .say for lazy home-prime $n
}

multi MAIN ($n, Bool :s(:$steps) = False) {
    home-prime $n
    andthen .tail
    andthen .put
}

