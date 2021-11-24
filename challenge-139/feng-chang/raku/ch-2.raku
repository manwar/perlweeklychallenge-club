#!/bin/env raku

put (1..∞).grep({ is-long-prime($_) })[^10];

sub is-long-prime(UInt:D $p --> Bool:D) {
    return False unless $p.is-prime;
    return False if $p < 3;
    return False if (1 .. $p-2).map(9 x *).grep(* %% $p);
    return (9 x $p-1) %% $p;
}
