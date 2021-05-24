#!/usr/bin/env raku
constant @fib = 0, 1, * + *  ... *;

sub climb-stairs ($n) {
    @fib[$n+1]
}

multi MAIN ( $n ) {
    say climb-stairs $n;
}

multi MAIN ( :test($)! ) {
    use Test;
    is climb-stairs(3),3;
    is climb-stairs(4),5;
    done-testing;
}
