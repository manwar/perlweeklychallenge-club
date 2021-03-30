#!/usr/bin/env raku

sub decimal-string ($n, $d) {
    $n/$d
    andthen .base-repeating
    andthen .[0] ~ ( if .[1] -> $_ { .fmt: '(%s)' } )
}

multi MAIN (Bool :$test!) {
    use Test;
    is decimal-string(1, 3), '0.(3)';
    is decimal-string(1, 2), '0.5';
    is decimal-string(5,66), '0.0(75)';
    is decimal-string(3, 7), '0.(428571)';
    done-testing;
}

multi MAIN ($n, $d) {
    say decimal-string $n, $d
}
