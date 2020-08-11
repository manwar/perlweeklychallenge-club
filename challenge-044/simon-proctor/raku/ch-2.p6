#!/usr/bin/env perl6

use v6.d;

multi recur(1) {
    return "1";
}

multi recur( \v where * %% 2 ) {
    return recur( v div 2 ), " * 2";
}

multi recur( \v ) {
    return "((", recur( v - 1 ), ") + 1)";
}


say "{recur( 200 ).flat.join('')} == 200";
