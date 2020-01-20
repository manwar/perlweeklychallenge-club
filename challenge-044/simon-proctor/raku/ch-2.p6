#!/usr/bin/env perl6

use v6.d;

multi sub recur( Int() $v where * %% 2 ) {
    return recur( $v / 2 ), " * 2";
}

multi sub recur( Int() $v ) {
    return "((", recur( $v - 1 ), ") + 1)";
}

multi sub recur($ where * ~~ 1) {
    return "1";
}

say "{recur( 100 ).flat.join('')} == 100";
