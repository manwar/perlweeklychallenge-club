#!/usr/bin/env raku

# ch-2.raku - Home primes
#
# 2021 Ryan Thompson <rjt@cpan.org>

use Prime::Factor;

sub MAIN(Int $n) {
    home_prime($n).say;
}

sub home_prime($n) {
    my @fac = prime-factors($n);

    @fac.elems == 1 ?? $n !! home_prime(@fac.join);
}
