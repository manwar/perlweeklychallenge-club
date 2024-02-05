#!/usr/bin/env raku

use v6.d;

sub three-power(Int:D $n where $n >= 0 --> Bool) {
    my $powers = Set(map({ $_ ** 3 }, 0 .. Int(sqrt($n))));
    return True if $n (elem) $powers;
    return False;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is three-power(27), True, 'works for 27';
    is three-power(0), True, 'works for 0';
    is three-power(6), False, 'works for 6';
}

#| Take user provided number like 10
multi sub MAIN(Int:D $n) {
    say three-power($n);
}
