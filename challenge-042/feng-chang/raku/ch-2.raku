#!/bin/env raku

sub is-balanced(Str:D $s --> Bool) {
    my Int $i;
    for $s.comb {
        when '(' { ++$i }
        when ')' { --$i; return False if $i < 0; }
        default  { return False }
    }

    $i == 0;
}

multi MAIN('test') {
    use Test;

    ok is-balanced('()'), '() is good';
    ok is-balanced('(())'), '(()) is good';

    nok is-balanced(')('), ')( is bad';
    nok is-balanced('())()'), '())() is bad';
}

multi MAIN(Str:D $string-of-braces) {
    given $string-of-braces {
        put "$_ -{ ' not' if !is-balanced($_) } ok";
    }
}
