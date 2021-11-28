#!/bin/env raku

multi sub is-two-friendly(0)         { True }
multi sub is-two-friendly(2)         { True }
multi sub is-two-friendly(UInt:D \n) { n %% 2 and is-two-friendly(n div 2)  }

sub MAIN(UInt:D \m, UInt:D \n) {
    put +is-two-friendly(m gcd n);
}
