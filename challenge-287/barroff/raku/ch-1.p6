#!/usr/bin/env raku

use v6.d;

grammar Valid-Number {
    token TOP { [ <integer>|<decimal> ] <exponent>? }
    token sign { [ '+'|'-' ] }
    token num { \d+ }
    token dot { '.' }
    token integer { <sign>? <num> }
    token decimal { <sign>? [ <num> <dot> <num>? || <dot> <num> ] }
    token exponent { [ 'e'|'E' ] <integer>}
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 7;

    ok Valid-Number.parse('1'), 'works for "1"';
    nok Valid-Number.parse('a'), 'works for "a"';
    nok Valid-Number.parse('.'), 'works for "."';
    nok Valid-Number.parse('1.2e4.2'), 'works for "1.2e4.2"';
    ok Valid-Number.parse('-1.'), 'works for "-1."';
    ok Valid-Number.parse('+1E-8'), 'works for "+1E-8"';
    ok Valid-Number.parse('.44'), 'works for ".44"';
}

#| Take user provided string like "'1.2e-3.4"
multi sub MAIN(Str $str) {
    if Valid-Number.parse($str) {
        say "a valid number";
    } else {
        say "not a valid number";
    };
}
